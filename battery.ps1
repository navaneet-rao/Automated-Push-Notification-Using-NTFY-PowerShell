
$batteryStatus = Get-WmiObject Win32_Battery
$batteryLevel = $batteryStatus.EstimatedChargeRemaining
if ($batteryLevel -lt 100) {
    Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "the battery is at  $batteryLevel%"
    Write-Output "battery is less than 100% "
}
elseif ($batteryLevel -lt 30) {
    Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "the battery level is low, at  $batteryLevel% - plz plug into the outlet"
    Write-Output "battery is less than 30%"
}
# while ($true) {
#     $batteryStatus = Get-WmiObject Win32_Battery
#     $batteryLevel = $batteryStatus.EstimatedChargeRemaining
#     if ($batteryLevel -lt 40) {
#         Invoke-RestMethod -Uri "ntfy.sh/PublicDog" -Method POST -Body "the battery is low!! at  $batteryLevel %"
#         Write-Output "it worked"
#     }
#     Start-Sleep -Seconds 10
# }
    
    