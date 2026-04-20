[CmdletBinding()]
param(
    [string]$GodotVersion = "4.6.2",
    [string]$GodotChannel = "stable",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$versionTag = "$GodotVersion-$GodotChannel"
$templateDirName = "$GodotVersion.$GodotChannel"
$tplRoot = Join-Path $env:APPDATA "Godot/export_templates/$templateDirName"

$marker = Join-Path $tplRoot "version.txt"
if ((Test-Path -LiteralPath $marker) -and -not $Force) {
    Write-Host "Templates already installed at $tplRoot (use -Force to reinstall)."
    exit 0
}

$fileName = "Godot_v$versionTag`_export_templates.tpz"
$url = "https://github.com/godotengine/godot/releases/download/$versionTag/$fileName"

$tpz = Join-Path $env:TEMP $fileName
$zipCopy = "$tpz.zip"
$extractRoot = Join-Path $env:TEMP "godot_templates_extract_$versionTag"

Write-Host "Downloading $url"
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $url -OutFile $tpz -UseBasicParsing
Write-Host ("Downloaded {0} bytes" -f (Get-Item -LiteralPath $tpz).Length)

if (Test-Path -LiteralPath $extractRoot) {
    Remove-Item -Recurse -Force -LiteralPath $extractRoot
}
Copy-Item -Force -LiteralPath $tpz -Destination $zipCopy
Expand-Archive -Force -LiteralPath $zipCopy -DestinationPath $extractRoot

$srcInner = Join-Path $extractRoot "templates"
if (-not (Test-Path -LiteralPath $srcInner)) {
    throw "Unexpected archive layout: missing 'templates' folder inside $extractRoot"
}

New-Item -ItemType Directory -Force -Path $tplRoot | Out-Null
Copy-Item -Force -Recurse (Join-Path $srcInner "*") $tplRoot

$count = (Get-ChildItem -LiteralPath $tplRoot | Measure-Object).Count
Write-Host ("Installed {0} files to {1}" -f $count, $tplRoot)

Remove-Item -Force -LiteralPath $zipCopy -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -LiteralPath $extractRoot -ErrorAction SilentlyContinue

exit 0
