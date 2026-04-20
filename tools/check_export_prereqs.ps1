[CmdletBinding()]
param(
    [string]$GodotPath = "",
    [switch]$Json
)

$ErrorActionPreference = "Stop"

function Add-Result {
    param(
        [string]$Name,
        [bool]$Ok,
        [string]$Details,
        [bool]$Required = $true
    )
    return [PSCustomObject]@{
        name = $Name
        ok = $Ok
        required = $Required
        details = $Details
    }
}

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

    return ""
}

$results = @()

$godot = Resolve-GodotPath -Provided $GodotPath
if ([string]::IsNullOrWhiteSpace($godot)) {
    $results += Add-Result -Name "godot_cli" -Ok $false -Required $true -Details "Godot console binary not found. Set -GodotPath or GODOT_PATH env var."
} else {
    $results += Add-Result -Name "godot_cli" -Ok $true -Required $true -Details "Using: $godot"
}

$templateRoot = Join-Path $env:APPDATA "Godot/export_templates/4.6.2.stable"
$webDebug = Join-Path $templateRoot "web_nothreads_debug.zip"
$webRelease = Join-Path $templateRoot "web_nothreads_release.zip"
$androidTpl = Join-Path $templateRoot "android_source.zip"

$results += Add-Result -Name "templates_windows" -Ok $true -Required $false -Details "Windows template ships with editor binaries."
$results += Add-Result -Name "templates_web" -Ok ((Test-Path -LiteralPath $webDebug) -and (Test-Path -LiteralPath $webRelease)) -Required $true -Details "Expected: $webDebug and $webRelease"
$results += Add-Result -Name "templates_android" -Ok (Test-Path -LiteralPath $androidTpl) -Required $true -Details "Expected: $androidTpl"

$javaOk = $false
$javaDetail = "JAVA_HOME not set"
if ($env:JAVA_HOME) {
    $javaExe = Join-Path $env:JAVA_HOME "bin/java.exe"
    if (Test-Path -LiteralPath $javaExe) {
        $javaOk = $true
        $javaDetail = "JAVA_HOME: $($env:JAVA_HOME)"
    } else {
        $javaDetail = "JAVA_HOME set but java.exe missing under bin/"
    }
}
$results += Add-Result -Name "java_sdk" -Ok $javaOk -Required $true -Details $javaDetail

$sdkRoot = ""
if ($env:ANDROID_SDK_ROOT) { $sdkRoot = $env:ANDROID_SDK_ROOT }
elseif ($env:ANDROID_HOME) { $sdkRoot = $env:ANDROID_HOME }

$androidOk = $false
$androidDetails = "ANDROID_SDK_ROOT / ANDROID_HOME not set"
if ($sdkRoot) {
    $platformTools = Join-Path $sdkRoot "platform-tools"
    $buildTools = Join-Path $sdkRoot "build-tools"
    $adb = Join-Path $platformTools "adb.exe"
    $hasBuildTools = (Test-Path -LiteralPath $buildTools) -and ((Get-ChildItem -LiteralPath $buildTools -Directory -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0)
    $androidOk = (Test-Path -LiteralPath $adb) -and $hasBuildTools
    $androidDetails = "SDK: $sdkRoot | adb: $([bool](Test-Path -LiteralPath $adb)) | build-tools: $hasBuildTools"
}
$results += Add-Result -Name "android_sdk" -Ok $androidOk -Required $true -Details $androidDetails

$summary = [PSCustomObject]@{
    ok = (($results | Where-Object { $_.required -and -not $_.ok } | Measure-Object).Count -eq 0)
    results = $results
}

if ($Json) {
    $summary | ConvertTo-Json -Depth 6
} else {
    Write-Host "=== Export prerequisites check ==="
    foreach ($r in $results) {
        $status = if ($r.ok) { "OK" } else { "MISSING" }
        $req = if ($r.required) { "required" } else { "optional" }
        Write-Host ("[{0}] {1} ({2}) - {3}" -f $status, $r.name, $req, $r.details)
    }
    if ($summary.ok) {
        Write-Host "All required prerequisites are available." -ForegroundColor Green
    } else {
        Write-Host "Some required prerequisites are missing." -ForegroundColor Yellow
    }
}

if (-not $summary.ok) {
    exit 1
}
