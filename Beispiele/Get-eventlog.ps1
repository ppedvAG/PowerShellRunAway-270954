param(
[int]$EventId,

[int]$Newest,

[string]$Computername 
)
Get-WinEvent -LogName Security -ComputerName $Computername | Where-Object Id -eq $EventId | Select-Object -First $Newest

