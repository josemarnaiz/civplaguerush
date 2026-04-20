param(
    [Parameter(Mandatory=$true)][string]$Command,
    [Parameter(Mandatory=$false)][hashtable]$Params = @{},
    [int]$TimeoutMs = 8000,
    [string]$Host2 = "127.0.0.1",
    [int]$Port = 9090
)

$ErrorActionPreference = "Stop"

$client = New-Object System.Net.Sockets.TcpClient
$iar = $client.BeginConnect($Host2, $Port, $null, $null)
if (-not $iar.AsyncWaitHandle.WaitOne($TimeoutMs)) {
    $client.Close()
    throw "Timeout connecting to ${Host2}:${Port}"
}
$client.EndConnect($iar)
$client.NoDelay = $true
$client.ReceiveTimeout = $TimeoutMs
$client.SendTimeout = $TimeoutMs

$stream = $client.GetStream()

$payload = @{ command = $Command; params = $Params } | ConvertTo-Json -Depth 20 -Compress
$bytes = [System.Text.Encoding]::UTF8.GetBytes($payload + "`n")
$stream.Write($bytes, 0, $bytes.Length)
$stream.Flush()

$sb = New-Object System.Text.StringBuilder
$buffer = New-Object byte[] 8192
$deadline = [DateTime]::UtcNow.AddMilliseconds($TimeoutMs)
while ([DateTime]::UtcNow -lt $deadline) {
    if ($stream.DataAvailable) {
        $read = $stream.Read($buffer, 0, $buffer.Length)
        if ($read -le 0) { break }
        [void]$sb.Append([System.Text.Encoding]::UTF8.GetString($buffer, 0, $read))
        $text = $sb.ToString()
        $nl = $text.IndexOf("`n")
        if ($nl -ge 0) {
            $line = $text.Substring(0, $nl)
            Write-Output $line
            break
        }
    } else {
        Start-Sleep -Milliseconds 50
    }
}

$client.Close()
