$serverList = Get-Content .\servers.txt
foreach ($server in $serverList) {
    try {
        $null = Test-Connection -ComputerName $server -Count 1 -ErrorAction Stop
        Write-Output "$server -OK"
    }
    catch {
        Write-Output "$server - Connection Failed"
    }
}