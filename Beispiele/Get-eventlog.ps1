param(
$EventId,
$Newest,
$Computername 
)
Get-WinEvent -LogName Security -ComputerName $Computername | Where-Object Id -eq $EventId | Select-Object -First $Newest

