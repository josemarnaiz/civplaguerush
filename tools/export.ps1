[CmdletBinding()]
param(
    [ValidateSet("WindowsDesktop", "Web", "Android")]
    [string]$Preset,
    [switch]$All,
    [string]$GodotPath = "",
    [switch]$Release,
    [switch]$SkipPrereqCheck
)

$ErrorActionPreference = "Stop"

if (-not $All -and [string]::IsNullOrWhiteSpace($Preset)) {
    throw "Use -Preset <WindowsDesktop|Web|Android> or -All."
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$checkScript = Join-Path $projectRoot "tools/check_export_prereqs.ps1"

function Resolve-GodotPath {
    param([string]$Provided)

    if (-not [string]::IsNullOrWhiteSpace($Provided) -and (Test-Path -LiteralPath $Provided)) {
        return (Resolve-Path -LiteralPath $Provided).Path
    }

    if ($env:GODOT_PATH -and (Test-Path -LiteralPath $env:GODOT_PATH)) {
        return (Resolve-Path -LiteralPath $env:GODOT_PATH).Path
    }

    $fallback = "F:/Godot_v4.6.2-stable_win64.exe/Godot_v4.6.2-stable_win64_console.exe"
    if (Test-Path -LiteralPath $fallback) {
        return (Resolve-Path -LiteralPath $fallback).Path
    }

    throw "Godot binary not found. Set -GodotPath or GODOT_PATH."
}

function Preset-Path {
    param([string]$Name)
    switch ($Name) {
        "WindowsDesktop" { return "build/windows/CivPlagueRush.exe" }
        "Web"            { return "build/web/index.html" }
        "Android"        { return "build/android/CivPlagueRush.apk" }
        default           { throw "Unknown preset: $Name" }
    }
}

function Count-CtexFiles {
    $importedDir = Join-Path $projectRoot ".godot/imported"
    if (-not (Test-Path -LiteralPath $importedDir)) { return 0 }
    return (Get-ChildItem -LiteralPath $importedDir -Filter "*.ctex" -ErrorAction SilentlyContinue | Measure-Object).Count
}

function Invoke-Godot {
    # The non-console Godot Windows build detaches from the parent console and
    # returns control to the shell before actually finishing. Running it via
    # Start-Process -Wait forces PowerShell to block until the worker process
    # exits, so we can rely on Test-Path for the output file afterwards.
    param(
        [string]$Godot,
        [string[]]$Arguments
    )
    $p = Start-Process -FilePath $Godot -ArgumentList $Arguments -NoNewWindow -Wait -PassThru
    return $p.ExitCode
}

function Ensure-Imported {
    param([string]$Godot)

    $expected = 30   # rough lower-bound for the project's imported textures
    if ((Count-CtexFiles) -ge $expected) { return }

    Write-Host "--- Importing project (cold cache) ---"
    for ($i = 1; $i -le 3; $i++) {
        Write-Host ("Import pass {0}..." -f $i)
        $code = Invoke-Godot -Godot $Godot -Arguments @("--headless", "--path", $projectRoot, "--import", "--quit")
        $count = Count-CtexFiles
        Write-Host ("After pass {0}: exit={1} ctex={2}" -f $i, $code, $count)
        if ($count -ge $expected) { return }
    }
    Write-Host "Warning: only $(Count-CtexFiles) .ctex files generated; export may still fail."
}

function Run-Export {
    param(
        [string]$Godot,
        [string]$PresetName
    )

    $relativeOut = Preset-Path -Name $PresetName
    $absOut = Join-Path $projectRoot $relativeOut
    $outDir = Split-Path -Parent $absOut
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null

    Ensure-Imported -Godot $Godot

    $modeFlag = if ($Release) { "--export-release" } else { "--export-debug" }
    Write-Host ("--- Exporting {0} ({1}) -> {2} ---" -f $PresetName, $modeFlag, $absOut)

    $exit = Invoke-Godot -Godot $Godot -Arguments @("--headless", "--path", $projectRoot, "--verbose", $modeFlag, $PresetName, $absOut)
    Write-Host ("Godot exited with code {0}" -f $exit)
    if ($exit -ne 0) {
        throw "Export failed for preset '$PresetName' (exit $exit)"
    }

    if (-not (Test-Path -LiteralPath $absOut)) {
        Write-Host "Output missing. Listing build dir contents for diagnosis:"
        if (Test-Path -LiteralPath $outDir) {
            Get-ChildItem -LiteralPath $outDir -Recurse | Format-Table -AutoSize
        } else {
            Write-Host ("Output directory '{0}' does not exist." -f $outDir)
        }
        throw "Export reported success but output missing: $absOut"
    }

    $file = Get-Item -LiteralPath $absOut
    Write-Host ("OK: {0} ({1} bytes)" -f $relativeOut, $file.Length) -ForegroundColor Green
}

$godot = Resolve-GodotPath -Provided $GodotPath

if (-not $SkipPrereqCheck) {
    if (-not (Test-Path -LiteralPath $checkScript)) {
        throw "Prereq check script missing: $checkScript"
    }
    Write-Host "Running prerequisite check..."
    $presetForCheck = if ($All) { "All" } else { $Preset }
    & $checkScript -GodotPath $godot -Preset $presetForCheck
    if ($LASTEXITCODE -ne 0) {
        throw "Prerequisite check failed. Fix reported items or use -SkipPrereqCheck."
    }
}

$targets = @()
if ($All) {
    $targets = @("WindowsDesktop", "Web", "Android")
} else {
    $targets = @($Preset)
}

$failed = @()
foreach ($t in $targets) {
    try {
        Run-Export -Godot $godot -PresetName $t
    } catch {
        Write-Host ("FAILED: {0} - {1}" -f $t, $_.Exception.Message) -ForegroundColor Red
        $failed += $t
        if (-not $All) { throw }
    }
}

if ($failed.Count -gt 0) {
    Write-Host ("Export completed with failures: {0}" -f ($failed -join ", ")) -ForegroundColor Yellow
    exit 1
}

Write-Host "All requested exports succeeded." -ForegroundColor Green
