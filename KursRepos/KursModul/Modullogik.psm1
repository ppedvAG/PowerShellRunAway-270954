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

<#
.SYNOPSIS
    Pipelinef�higkeit ByValue herstellen
.DESCRIPTION
    Dieses Beispiel, welches jedes �bergebene Zeichen in einer anderen Farbe ausgibt wird verwendet um Piplinef�higkeit ByValue zu demonstrieren
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
    Pipelinef�higkeit ByPropertyName herstellen
.DESCRIPTION
    Dieses Beispiel, welches jedes �bergebene Wort in einer anderen Farbe ausgibt wird verwendet um Piplinef�higkeit ByValue zu demonstrieren
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
    F�r die vollst�ndige Pipelinef�higkeit wird BPE ben�tigt
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
    Write-Host -Object "Der Begin Block wird zum Start einmal ausgef�hrt" -ForegroundColor Magenta
    #Ideal zum Importieren von Modulen, Initialisieren / Deklarieren von Funktionen usw
}
Process
{
    #Message "Wird einmal f�r jedes �bergebene Objekt ausgef�hrt"
    Write-Host -Object $Name -ForegroundColor (Get-Random -Maximum 15)
}
End
{
    Write-Host -Object "Der End Block wird zum Ende einmal ausgef�hrt" -ForegroundColor Magenta
    #Ideal zum schlie�en von RemoteVerbindungen oder zum gezielten Entladen von gesch�tzen Modulen
}

}

<#
.SYNOPSIS
 Weiteres Beispiel f�r Begin Process End
.DESCRIPTION
 M�gliche L�sung zur BPE �bung, bzw zu weiteren Demonstration
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
"Anzahl: $count,Gr��e: $SizeSum $Einheit"
}
}

<#
.SYNOPSIS
Beispiel f�r ParameterSets
.DESCRIPTION
Verwendung verschiedenster Eingabem�glichkeiten 
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
 Beispiel f�r Positional Binding
.DESCRIPTION
 Beispiel f�r das auscchalten des automatischen Positional Bindings und manuelles zuweisen von Positionen
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

<#
.SYNOPSIS
    Beispiel f�r die Verwendung von .Net Elementen in Powershell
.DESCRIPTION
    Dieses Beispiel zeigt, wie .Net-Klassen in PowerShell verwendet werden können wie zb System.Speech
#>
function Out-Voice
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [string]$Text
)
Begin
{
    Add-Type -assemblyName System.Speech
    $SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $audiosrv = Get-Service -Name "Audiosrv"
    if($audiosrv.Status -ne "Running")
    {
        Start-Service -Name "Audiosrv"
    }
}
Process
{
    $SpeechSynthesizer.Speak($Text)
}
End
{
    $SpeechSynthesizer.Dispose()
}
}