[CmdletBinding()]
param(
    [string]$Dir = "build/web",
    [int]$Port = 8787,
    [switch]$Open
)

$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$fullDir = Join-Path $projectRoot $Dir
if (-not (Test-Path -LiteralPath $fullDir)) {
    throw "Web build not found: $fullDir. Run tools/export.ps1 -Preset Web first."
}

$py = Get-Command python -ErrorAction SilentlyContinue
if (-not $py) { $py = Get-Command py -ErrorAction SilentlyContinue }
if (-not $py) {
    throw "Python not found on PATH. Install Python 3 or serve $fullDir with any static HTTP server."
}

$url = "http://127.0.0.1:$Port/"
Write-Host "Serving $fullDir at $url (Ctrl+C to stop)"
if ($Open) { Start-Process $url | Out-Null }

& $py.Path -m http.server $Port --bind 127.0.0.1 --directory $fullDir
