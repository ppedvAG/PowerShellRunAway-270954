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

[string]$TestFilesDirPath = Join-Path -Path $Path -ChildPath $Name
if(Test-Path -Path $TestFilesDirPath -PathType Container)
{
    if($Force)
    {
        Remove-Item -Path $TestFilesDirPath -Recurse -Force
    }
    else
    {
        Write-Host -Object "Ordner vorhanden"
        exit
    }
}

$TestFilesDir = New-Item -Path $Path -Name $Name -ItemType Directory

for($i = 1; $i -le $FileCount; $i++)
{
    $Filename = "File" + ("{0:D2}" -f $i) + ".txt"
    New-Item -Path $TestFilesDir.FullName -Name $Filename -ItemType File
}

for($i = 1; $i -le $Dircount; $i++)
{
    $Dirname = "Dir" + ("{0:D2}" -f $i) 
    $subdir = New-Item -Path $TestFilesDir.FullName -Name $Dirname -ItemType Directory

    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileName = $Dirname + "-File" + ("{0:D2}" -f $j) + ".txt"
        New-Item -Path $subdir.FullName -Name $Filename -ItemType File
    }
}