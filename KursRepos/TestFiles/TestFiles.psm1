function New-TestFiles
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[string]$Path,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateLength(5,20)]
[string]$Name = "File"
)

for($i = 1; $i -le $FileCount; $i++)
{
    $Filename = "$Name" + ("{0:D2}" -f $i) + ".txt"
    New-Item -Path $Path -Name $Filename -ItemType File
}

}

function New-TestFilesDir
{
param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[string]$Path,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateRange(0,99)]
[int]$DirCount = 2,

[ValidateLength(5,20)]
[string]$Name = "TestFiles2",

[switch]$Force
)

#function
# Funktionen sollten sich an das Bennneungsschema halten verb-Noun 
# bzw an die approved Verbs

#

[string]$TestFilesDirPath = Join-Path -Path $Path -ChildPath $Name
if(Test-Path -Path $TestFilesDirPath -PathType Container)
{
    if($Force)
    {
        Remove-Item -Path $TestFilesDirPath -Recurse -Force
    }
    else
    {
        Write-Error -Message "Ordner bereits vorhanden" -TargetObject (Get-Item -Path $TestFilesDirPath) -ErrorAction Stop
    <#
        Write-Host -Object "Ordner vorhanden"
        exit
        #>
    }
}

$TestFilesDir = New-Item -Path $Path -Name $Name -ItemType Directory

New-TestFiles -Path $TestFilesDir.FullName -FileCount $FileCount
<# ersetzt durch Function
for($i = 1; $i -le $FileCount; $i++)
{
    $Filename = "File" + ("{0:D2}" -f $i) + ".txt"
    New-Item -Path $TestFilesDir.FullName -Name $Filename -ItemType File
}#>

for($i = 1; $i -le $Dircount; $i++)
{
    $Dirname = "Dir" + ("{0:D2}" -f $i) 
    $subdir = New-Item -Path $TestFilesDir.FullName -Name $Dirname -ItemType Directory

    New-TestFiles -Path $subdir.FullName -FileCount $FileCount -Name "$Dirname-File"
    <# ersetzt durch Function
    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileName = $Dirname + "-File" + ("{0:D2}" -f $j) + ".txt"
        New-Item -Path $subdir.FullName -Name $Filename -ItemType File
    }#>
}
}