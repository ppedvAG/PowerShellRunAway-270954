[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5,

[string]$Computername = "localhost"
)
Write-Verbose -Message "Ausgabe Optional"
Get-WinEvent -LogName Security -ComputerName $Computername | Where-Object Id -eq $EventId | Select-Object -First $Newest

