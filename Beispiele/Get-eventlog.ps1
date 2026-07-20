param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5,

[string]$Computername = "localhost"
)
Get-WinEvent -LogName Security -ComputerName $Computername | Where-Object Id -eq $EventId | Select-Object -First $Newest

