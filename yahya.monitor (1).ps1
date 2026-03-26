$HostsFile = ".\hosts.txt"
$LogFile = ".\Network_Monitor_Log.txt"

Add-Content -Path $LogFile -Value "--- Test started at: $(Get-Date) ---"

if (-not (Test-Path $HostsFile)) {
    Add-Content -Path $LogFile -Value "Error: hosts.txt file not found!"
    Write-Host "Error: hosts.txt file not found!" -ForegroundColor Red
    exit
}

$Targets = Get-Content $HostsFile

Write-Host "Starting test..." -ForegroundColor Yellow

foreach ($Target in $Targets) {
    if ($Target -like "#*") { continue }

    Write-Host "Testing: $Target" -NoNewline

    $Result = Test-Connection -ComputerName $Target -Count 2 -ErrorAction SilentlyContinue

    if ($Result) {
        $Status = "Connection successful (SUCCESS)"
        Write-Host " | $Status" -ForegroundColor Green
        Add-Content -Path $LogFile -Value "$([DateTime]::Now.ToString('yyyy-MM-dd HH:mm:ss')) | Target: $Target | $Status"
    } else {
        $Status = "Connection failed (FAILED)"
        Write-Host " | $Status" -ForegroundColor Red
        Add-Content -Path $LogFile -Value "$([DateTime]::Now.ToString('yyyy-MM-dd HH:mm:ss')) | Target: $Target | $Status"
    }
}

Write-Host "`nTest completed. Check the Log file." -ForegroundColor Cyan
Add-Content -Path $LogFile -Value "--- Test finished. ---`n"

Invoke-Item $LogFile
