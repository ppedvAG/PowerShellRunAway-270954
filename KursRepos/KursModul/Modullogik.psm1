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

<#
.SYNOPSIS
 Weiteres Beispiel für Begin Process End
.DESCRIPTION
 Mögliche Lösung zur BPE Übung, bzw zu weiteren Demonstration
#>
function Measure-Files
{
[cmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
[long]$Length
)
Begin
{
[int]$count 
[long]$SizeSum
}
Process
{
    $count ++
    $SizeSum += $Length
}
End
{
$Einheit
if($SizeSum -gt 1KB)
{
    $Einheit = "KB"
    $SizeSum = $SizeSum / 1KB
}
elseif ($SizeSum -gt 1MB)
{
    $Einheit = "MB"
    $SizeSum = $SizeSum / 1MB
}
elseif ($SizeSum -gt 1GB)
{
    $Einheit = "GB"
    $SizeSum = $SizeSum / 1GB
}
elseif ($SizeSum -gt 1TB)
{
    $Einheit = "TB"
    $SizeSum = $SizeSum / 1TB
}
"Anzahl: $count,Größe: $SizeSum $Einheit"
}
}

<#
.SYNOPSIS
Beispiel für ParameterSets
.DESCRIPTION
Verwendung verschiedenster Eingabemöglichkeiten 
#>
function Test-ParameterSet
{
[cmdletBinding(DefaultParameterSetName="Service")]
param(

[Parameter(Mandatory=$true, ParameterSetName="Prozess", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
[string]$ProcessName,

[Parameter(Mandatory=$true, ParameterSetName="Service", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
[string]$ServiceName,

[Parameter(Mandatory=$true, ParameterSetName="Service", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
[string]$Status,

[Parameter(Mandatory=$true, ParameterSetName="Prozess", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
[int]$PM
)
Write-Verbose -Message "ParameterSet: $($PSCmdlet.ParameterSetName)"
switch($PSCmdlet.ParameterSetName)
{
    "Prozess" {"$ProcessName  $($PM)"}
    "Service" {"$ServiceName $Status" }
}


}

<#
.SYNOPSIS
 Beispiel für Positional Binding
.DESCRIPTION
 Beispiel für das auscchalten des automatischen Positional Bindings und manuelles zuweisen von Positionen
#>
function Test-Positions
{
[cmdletBinding(PositionalBinding= $false)]
param(
[Parameter(Position=0)]
$param1,

$Param2,

$param3
)
Write-Host -Object "Param1: " -NoNewline
Write-Host -Object $param1 -ForegroundColor Magenta
Write-Host -Object "Param2: " -NoNewline
Write-Host -Object $param2 -ForegroundColor Magenta
Write-Host -Object "Param3: " -NoNewline
Write-Host -Object $param3 -ForegroundColor Magenta
}
