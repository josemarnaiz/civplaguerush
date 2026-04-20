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

function Ensure-Imported {
    param([string]$Godot)

    $importedDir = Join-Path $projectRoot ".godot/imported"
    if (Test-Path -LiteralPath $importedDir) {
        $hasArtifacts = (Get-ChildItem -LiteralPath $importedDir -Filter "*.ctex" -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0
        if ($hasArtifacts) { return }
    }
    Write-Host "--- Importing project (cold cache) ---"
    & $Godot --headless --path $projectRoot --import --quit | Out-Null
    # First import sometimes returns a non-zero status while still producing
    # valid .ctex files. Run a second pass so subsequent exports see them.
    & $Godot --headless --path $projectRoot --import --quit | Out-Null
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
    Write-Host ("--- Exporting {0} ({1}) ---" -f $PresetName, $modeFlag)

    & $Godot --headless --path $projectRoot $modeFlag $PresetName $absOut
    if ($LASTEXITCODE -ne 0) {
        throw "Export failed for preset '$PresetName'"
    }

    if (-not (Test-Path -LiteralPath $absOut)) {
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
