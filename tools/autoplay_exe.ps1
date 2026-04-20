# Autoplay a built CivPlagueRush.exe through a full run via TCP MCP protocol.
#
# Launches the exported binary, drives it through the main menu and a fixed
# number of event turns by always picking the first choice, and snapshots
# screenshots along the way. Returns exit code 0 on success.
#
# Usage:
#   ./tools/autoplay_exe.ps1
#   ./tools/autoplay_exe.ps1 -Exe build/windows/CivPlagueRush.exe -Turns 12

[CmdletBinding()]
param(
    [string]$Exe = "build/windows/CivPlagueRush.exe",
    [int]$Turns = 12,
    [string]$OutDir = "build/windows/autoplay-runs",
    [int]$Port = 9090,
    [int]$BootTimeoutSec = 15
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
$exePath = Resolve-Path (Join-Path $projectRoot $Exe)
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$runDir = Join-Path $projectRoot (Join-Path $OutDir $stamp)
New-Item -ItemType Directory -Force -Path $runDir | Out-Null

function Invoke-McpCommand {
    param(
        [System.Net.Sockets.TcpClient]$Client,
        [string]$Command,
        [hashtable]$Params = @{}
    )
    $payload = @{ command = $Command; params = $Params } | ConvertTo-Json -Depth 8 -Compress
    $stream = $Client.GetStream()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload + "`n")
    $stream.Write($bytes, 0, $bytes.Length)
    $stream.Flush()

    $response = New-Object System.Text.StringBuilder
    $buffer = New-Object byte[] 4096
    while (-not $response.ToString().Contains("`n")) {
        if (-not $stream.DataAvailable) { Start-Sleep -Milliseconds 30; continue }
        $read = $stream.Read($buffer, 0, $buffer.Length)
        if ($read -le 0) { break }
        [void]$response.Append([System.Text.Encoding]::UTF8.GetString($buffer, 0, $read))
    }
    $line = $response.ToString().Split("`n")[0]
    return ($line | ConvertFrom-Json)
}

function Save-Screenshot {
    param(
        [System.Net.Sockets.TcpClient]$Client,
        [string]$Name
    )
    $resp = Invoke-McpCommand -Client $Client -Command "screenshot"
    if (-not $resp.success) { Write-Warning "screenshot failed: $($resp.error)"; return }
    $out = Join-Path $runDir "$Name.png"
    [IO.File]::WriteAllBytes($out, [Convert]::FromBase64String($resp.data))
    Write-Host "  snapshot -> $out ($($resp.width)x$($resp.height))"
}

Write-Host "=== CivPlagueRush autoplay ==="
Write-Host "exe:     $exePath"
Write-Host "turns:   $Turns"
Write-Host "runDir:  $runDir"

$proc = Start-Process -FilePath $exePath -PassThru
Write-Host "launched pid=$($proc.Id)"

$deadline = (Get-Date).AddSeconds($BootTimeoutSec)
$client = $null
while ((Get-Date) -lt $deadline) {
    try {
        $c = New-Object System.Net.Sockets.TcpClient
        $c.ConnectAsync("127.0.0.1", $Port).Wait(750)
        if ($c.Connected) { $client = $c; break }
        $c.Close()
    } catch {}
    Start-Sleep -Milliseconds 300
}
if (-not $client) {
    Write-Error "MCP port $Port never opened"
    $proc | Stop-Process -Force
    exit 1
}
Write-Host "connected to MCP server"

try {
    Start-Sleep -Milliseconds 500
    Save-Screenshot -Client $client -Name "00_main_menu"

    # Click StartRunButton on the main menu.
    $ui = Invoke-McpCommand -Client $client -Command "get_ui_elements"
    $startBtn = $ui.elements | Where-Object { $_.name -eq "StartRunButton" } | Select-Object -First 1
    if (-not $startBtn) { throw "StartRunButton not found" }
    $cx = [int]($startBtn.position.x + $startBtn.size.width / 2)
    $cy = [int]($startBtn.position.y + $startBtn.size.height / 2)
    Write-Host "clicking StartRunButton at ($cx,$cy)"
    [void](Invoke-McpCommand -Client $client -Command "click" -Params @{ x = $cx; y = $cy })
    Start-Sleep -Milliseconds 500
    Save-Screenshot -Client $client -Name "01_run_started"

    for ($i = 1; $i -le $Turns; $i++) {
        $ui = Invoke-McpCommand -Client $client -Command "get_ui_elements"
        # Choice buttons are created dynamically inside the Choices VBoxContainer
        # and get auto-generated names, so match by path instead.
        $choices = $ui.elements | Where-Object {
            $_.type -eq "Button" -and $_.path -match "/Choices/" -and $_.size.width -gt 0
        }
        if (-not $choices) {
            Write-Host "turn $i : no choice buttons visible, assuming run ended"
            break
        }
        $target = $choices | Select-Object -First 1
        $cx = [int]($target.position.x + $target.size.width / 2)
        $cy = [int]($target.position.y + $target.size.height / 2)
        Write-Host "turn $i : clicking $($target.name) at ($cx,$cy)"
        [void](Invoke-McpCommand -Client $client -Command "click" -Params @{ x = $cx; y = $cy })
        Start-Sleep -Milliseconds 350

        # If we ended up in a region pick mode (player_chooses event), the choice
        # buttons are disabled and the map waits for a region click. Resolve it
        # by clicking the centroid of the first selectable region.
        $pick = Invoke-McpCommand -Client $client -Command "eval" -Params @{
            code = "var scene = get_tree().current_scene; if not scene.has_method('_begin_region_pick_mode'): return {ok=false}; if not scene._awaiting_region_pick: return {ok=false}; var rm = scene.region_map; var ids = rm._selectable_ids.keys(); if ids.is_empty(): return {ok=false}; var id = String(ids[0]); var c = rm._centroids.get(id, Vector2.ZERO); var p = c * rm.size + rm.global_position; return {ok=true, id=id, x=int(p.x), y=int(p.y)}"
        }
        if ($pick -and $pick.result -and $pick.result.ok) {
            Write-Host "  region pick -> $($pick.result.id) at ($($pick.result.x),$($pick.result.y))"
            [void](Invoke-McpCommand -Client $client -Command "click" -Params @{ x = $pick.result.x; y = $pick.result.y })
            Start-Sleep -Milliseconds 350
        }

        Save-Screenshot -Client $client -Name ("{0:D2}_turn_{1:D2}" -f ($i + 1), $i)
    }

    Save-Screenshot -Client $client -Name "99_final"

    $finalState = Invoke-McpCommand -Client $client -Command "eval" -Params @{
        code = "var s = get_tree().current_scene; return {scene=String(s.name), node_count=s.get_child_count()}"
    }
    Write-Host ("final scene: " + ($finalState.result | ConvertTo-Json -Compress))
}
finally {
    try { $client.Close() } catch {}
    if (-not $proc.HasExited) { $proc | Stop-Process -Force }
}

Write-Host "=== DONE ==="
Write-Host "artifacts in: $runDir"
