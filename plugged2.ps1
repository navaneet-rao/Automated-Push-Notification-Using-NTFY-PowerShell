# Initialize the previous status as unknown
$previousStatus = "Unknown"
$scriptRunning = $false

while ($true) {
    # Get the battery status
    $batteryStatus = Get-WmiObject -Class Win32_Battery

    # Check if a battery is present
    if ($batteryStatus) {
        # Get the current battery status
        $currentStatus = $batteryStatus.BatteryStatus

        # Check if the status has changed
        if ($currentStatus -ne $previousStatus) {
            if ($currentStatus -eq 1) {
                Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "Navaneet-PC is running on battery"
                Write-Host "Laptop is running on battery."
                
                # Start your additional PowerShell script when on battery
                if (!$scriptRunning) {
                    Start-Process PowerShell.exe -ArgumentList "-File E:\ntfy-codes\battery.ps1" -NoNewWindow
                    $scriptRunning = $true
                }
            }
            else {
                Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "Navaneet-PC is plugged into the outlet"
                Write-Host "Laptop is not running on battery."

                # Stop the additional script if it's running
                if ($scriptRunning) {
                    # Stop-Process "-File E:\ntfy-codes\battery.ps1" -Force
                    $scriptRunning = $false
                }
            }

            # Update the previous status
            $previousStatus = $currentStatus
        }
    }
    else {
        # No battery found
        if ($previousStatus -ne "NoBattery") {
            Write-Host "No battery found."
            $previousStatus = "NoBattery"
        }
    }

    # Sleep for a while before checking again (adjust the interval as needed)
    # Start-Sleep -Seconds 60
}
