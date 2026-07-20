<#
.SYNOPSIS
 Kurzbeschreibung
.DESCRIPTION
 Lange Beschreibung was das Skript macht
.PARAMETER EventId
 4624 - Anmeldung
 4625 - fehlgeschlagene Anmeldung
 4634 - Abmeldung
.EXAMPLE
 Get-eventlog.ps1 -EventId 4624


   ProviderName: Microsoft-Windows-Security-Auditing

TimeCreated                     Id LevelDisplayName Message
-----------                     -- ---------------- -------
20.07.2026 14:06:23           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
20.07.2026 14:05:23           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
20.07.2026 14:04:23           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
20.07.2026 14:03:45           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
20.07.2026 14:03:45           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1#syntax-for-comment-based-help-in-scripts
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5,

[string]$Computername = "localhost"
)
Write-Verbose -Message "Ausgabe Optional"
Get-WinEvent -LogName Security -ComputerName $Computername | Where-Object Id -eq $EventId | Select-Object -First $Newest

