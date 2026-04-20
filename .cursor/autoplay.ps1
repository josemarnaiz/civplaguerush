$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $PSCommandPath
$McpScript = Join-Path $ScriptDir "mcp_client.ps1"

function MCP([string]$cmd, [hashtable]$p=@{}) {
    $raw = & $McpScript -Command $cmd -Params $p
    if ([string]::IsNullOrWhiteSpace($raw)) { return $null }
    return $raw | ConvertFrom-Json
}

function Get-UI() { return (MCP "get_ui_elements").elements }

function Find-Node($ui, [string]$name) {
    return $ui | Where-Object { $_.name -eq $name } | Select-Object -First 1
}

function Find-ChoiceButtons($ui) {
    return $ui | Where-Object {
        $_.type -eq "Button" -and $_.path -match "Choices" -and $_.name -ne "BackButton"
    }
}

function Center($node) {
    return @{ x = [int]($node.position.x + $node.size.width / 2); y = [int]($node.position.y + $node.size.height / 2) }
}

function Detect-Scene($ui) {
    if (Find-Node $ui "SummaryLabel") { return "MetaHub" }
    if (Find-Node $ui "StatsLabel")   { return "RunScene" }
    if (Find-Node $ui "StartRunButton") { return "MainMenu" }
    return "Unknown"
}

$log = [System.Collections.ArrayList]::new()
function Log($msg) {
    $line = "[{0:HH:mm:ss}] {1}" -f (Get-Date), $msg
    [void]$log.Add($line)
    Write-Host $line
}

$maxDecisions = 200
$i = 0
$lastScene = ""

while ($i -lt $maxDecisions) {
    $i++
    $ui = Get-UI
    $scene = Detect-Scene $ui
    if ($scene -ne $lastScene) { Log "Scene -> $scene"; $lastScene = $scene }

    if ($scene -eq "MetaHub") {
        $summary = (Find-Node $ui "SummaryLabel").text
        $credits = (Find-Node $ui "CreditsLabel").text
        Log "ENDGAME REACHED"
        Log "Summary: $summary"
        Log "Credits: $credits"
        break
    }

    if ($scene -eq "RunScene") {
        $turn  = (Find-Node $ui "TurnLabel").text
        $stats = (Find-Node $ui "StatsLabel").text
        $evt   = (Find-Node $ui "EventTitle").text
        $prog  = (Find-Node $ui "ProgressLabel").text
        Log "$turn | $evt | $prog"
        Log "Stats: $stats"

        $choices = Find-ChoiceButtons $ui
        if ($choices.Count -eq 0) { Log "No choices found"; Start-Sleep -Milliseconds 300; continue }
        $pick = $choices | Get-Random
        Log "Choice: $($pick.text)"
        $c = Center $pick
        $r = MCP "click" @{ x = $c.x; y = $c.y }
        Start-Sleep -Milliseconds 120
        continue
    }

    if ($scene -eq "MainMenu") {
        $btn = Find-Node $ui "StartRunButton"
        $c = Center $btn
        Log "Click Start Run"
        MCP "click" @{ x = $c.x; y = $c.y } | Out-Null
        Start-Sleep -Milliseconds 300
        continue
    }

    Start-Sleep -Milliseconds 200
}

Log "Taking final screenshot..."
$shot = MCP "screenshot"
if ($shot.success) {
    $outPath = Join-Path $ScriptDir "endgame.png"
    [IO.File]::WriteAllBytes($outPath, [Convert]::FromBase64String($shot.data))
    Log "Screenshot saved to $outPath"
}

$logPath = Join-Path $ScriptDir "autoplay.log"
$log | Set-Content -Path $logPath -Encoding UTF8
Write-Host "Log written to $logPath"
