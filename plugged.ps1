while ($true) {
    $batteryStatus = Get-WmiObject -Class Win32_Battery
    if ($batteryStatus) {
        if ($batteryStatus.BatteryStatus -eq 1) {
            Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "Navaneet-PC is running on battery"
            Write-Host "Laptop is running on battery."
        }
        else {
            Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "Navaneet-PC is plugged in power line"
            Write-Host "Laptop is not running on battery."
        }
    }
    else {
        Write-Host "No battery found."
    }
    Start-Sleep -Seconds 100
}


