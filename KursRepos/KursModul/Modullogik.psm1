<#
.SYNOPSIS
    Zählen wie viele Benutzer einen bestimmten Namen haben
.DESCRIPTION
    Zählen wie viele Benutzer einen bestimmten Namen haben in Langer Erklärungsform
#>
function Measure-GivenName
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateLength(3,50)]
    [string]$GivenName
)

    Import-Module ActiveDirectory -ErrorAction Stop
    $Measured = Get-AdUser -Filter {GivenName -eq $GivenName} | Measure-object

    $Measured.Count 
}

