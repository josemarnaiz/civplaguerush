$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $PSCommandPath
$McpScript = Join-Path $ScriptDir "mcp_client.ps1"

function MCP([string]$cmd, [hashtable]$p=@{}) {
    $raw = & $McpScript -Command $cmd -Params $p -TimeoutMs 10000
    if ([string]::IsNullOrWhiteSpace($raw)) { return $null }
    return $raw | ConvertFrom-Json
}

function Get-UI() { return (MCP "get_ui_elements").elements }
function Find-Node($ui, [string]$name) { return $ui | Where-Object { $_.name -eq $name } | Select-Object -First 1 }
function Find-Choices($ui) { return $ui | Where-Object { $_.type -eq "Button" -and $_.path -match "Choices" -and $_.name -ne "BackButton" } }
function Center($node) { return @{ x = [int]($node.position.x + $node.size.width / 2); y = [int]($node.position.y + $node.size.height / 2) } }
function Scene($ui) {
    if (Find-Node $ui "SummaryLabel") { return "MetaHub" }
    if (Find-Node $ui "StatsLabel")   { return "RunScene" }
    if (Find-Node $ui "StartRunButton") { return "MainMenu" }
    return "Unknown"
}
function Save-Shot($name) {
    $s = MCP "screenshot"
    if ($s.success) {
        $p = Join-Path $ScriptDir "$name.png"
        [IO.File]::WriteAllBytes($p, [Convert]::FromBase64String($s.data))
        Write-Host "Shot -> $p"
    }
}

function Click-At($node) {
    $c = Center $node
    MCP "click" @{ x = $c.x; y = $c.y } | Out-Null
    Start-Sleep -Milliseconds 120
}

function Play-Run([string]$tag) {
    Write-Host "=== Run: $tag ==="
    $safety = 300
    while ($safety-- -gt 0) {
        $ui = Get-UI
        $scene = Scene $ui
        if ($scene -eq "MetaHub") {
            $sum = (Find-Node $ui "SummaryLabel").text
            $cr  = (Find-Node $ui "CreditsLabel").text
            Write-Host "[$tag] ENDGAME"
            Write-Host "[$tag] $sum"
            Write-Host "[$tag] $cr"
            return $ui
        }
        if ($scene -eq "RunScene") {
            $turn  = (Find-Node $ui "TurnLabel").text
            $evt   = (Find-Node $ui "EventTitle").text
            $stats = (Find-Node $ui "StatsLabel").text
            Write-Host "[$tag] $turn | $evt"
            Write-Host "[$tag] $stats"
            $ch = Find-Choices $ui
            if ($ch.Count -gt 0) {
                $pick = $ch | Get-Random
                Write-Host "[$tag]   -> $($pick.text)"
                Click-At $pick
            } else { Start-Sleep -Milliseconds 200 }
            continue
        }
        if ($scene -eq "MainMenu") {
            Write-Host "[$tag] Click Start Run"
            Click-At (Find-Node $ui "StartRunButton")
            Start-Sleep -Milliseconds 200
            continue
        }
        Start-Sleep -Milliseconds 150
    }
    return $null
}

# --- CYCLE ---
Write-Host "Waiting for UI..."
$ready = $false
for ($i=0; $i -lt 60; $i++) {
    try { $ui = Get-UI; if ($ui) { $ready = $true; break } } catch {}
    Start-Sleep -Milliseconds 250
}
if (-not $ready) { throw "Game UI not reachable" }

# 1) MainMenu
$ui = Get-UI
Write-Host "Initial scene: $(Scene $ui)"
Save-Shot "cycle_01_mainmenu"

# 2) Run 1 -> endgame
$end1 = Play-Run "RUN1"
Save-Shot "cycle_02_endgame_run1"

# 3) Try unlock first affordable tech in MetaHub
$ui = Get-UI
$creditsText = (Find-Node $ui "CreditsLabel").text
Write-Host "MetaHub: $creditsText"
$unlockButtons = $ui | Where-Object { $_.type -eq "Button" -and $_.text -eq "Unlock" }
foreach ($b in $unlockButtons) {
    Write-Host "Attempt unlock via button at path $($b.path)"
    Click-At $b
    Start-Sleep -Milliseconds 200
    $ui2 = Get-UI
    $credits2 = (Find-Node $ui2 "CreditsLabel").text
    Write-Host "After unlock attempt: $credits2"
    break
}
Save-Shot "cycle_03_after_unlock"

# 4) Play Again
$ui = Get-UI
$playAgain = Find-Node $ui "PlayAgainButton"
if ($playAgain) {
    Write-Host "Click Play Again"
    Click-At $playAgain
    Start-Sleep -Milliseconds 300
}

# 5) Run 2 -> endgame
$end2 = Play-Run "RUN2"
Save-Shot "cycle_04_endgame_run2"

Write-Host "=== CYCLE COMPLETE ==="
