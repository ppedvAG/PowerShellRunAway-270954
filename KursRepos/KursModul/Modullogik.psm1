<#
.SYNOPSIS
    ZÃ¤hlen wie viele Benutzer einen bestimmten Namen haben
.DESCRIPTION
    ZÃ¤hlen wie viele Benutzer einen bestimmten Namen haben in Langer ErklÃ¤rungsform
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

<#
.SYNOPSIS
    Pipelinefähigkeit ByValue herstellen
.DESCRIPTION
    Dieses Beispiel, welches jedes übergebene Zeichen in einer anderen Farbe ausgibt wird verwendet um Piplinefähigkeit ByValue zu demonstrieren
#>
function Write-RainbowChar
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
[string]$InputObject
)

for($i = 0 ; $i -lt $InputObject.Length; $i ++)
{
    Write-Verbose -Message $i
    Write-Host -Object $InputObject[$i] -ForegroundColor (Get-Random -Maximum 15) -NoNewline
}

}

<#
.SYNOPSIS
    Pipelinefähigkeit ByPropertyName herstellen
.DESCRIPTION
    Dieses Beispiel, welches jedes übergebene Wort in einer anderen Farbe ausgibt wird verwendet um Piplinefähigkeit ByValue zu demonstrieren
#>
function Write-RainbowWord
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
[string]$Name
)

Write-Host -Object $Name -ForegroundColor (Get-Random -Maximum 15)

}

<#
.SYNOPSIS
    Für die vollständige Pipelinefähigkeit wird BPE benötigt
.DESCRIPTION
    Begin Process End Konstruktion 
#>
function Test-BPE
{
[cmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeLine = $true, ValueFromPipeLineByPropertyName = $true)]
[string]$Name

)
Begin
{
    Write-Host -Object "Der Begin Block wird zum Start einmal ausgeführt" -ForegroundColor Magenta
    #Ideal zum Importieren von Modulen, Initialisieren / Deklarieren von Funktionen usw
}
Process
{
    #Message "Wird einmal für jedes übergebene Objekt ausgeführt"
    Write-Host -Object $Name -ForegroundColor (Get-Random -Maximum 15)
}
End
{
    Write-Host -Object "Der End Block wird zum Ende einmal ausgeführt" -ForegroundColor Magenta
    #Ideal zum schließen von RemoteVerbindungen oder zum gezielten Entladen von geschützen Modulen
}

}