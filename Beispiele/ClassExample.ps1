class Vehicle
{
    [string]$Color
    [string]$Manufacturer
    [string]$Model
}

enum VehicleType
{
    Car
    Truck
    Motorcycle
}

class Car : Vehicle
{
    #Properties
    [int]$MaxSpeed
    [int]$PS
    [int]$Tires
    [VehicleType]$Type
    
    #Konstruktor
    # Wird aufgerufen, wenn eine Instanz des Objekts erstellt wird
    Car()
    {

    }
    Car([string]$Color, [string]$Manufacturer, [string]$Model, [int]$MaxSpeed, [int]$PS, [int]$Tires, [VehicleType]$Type)
    {
        $this.Color = $Color
        $this.Manufacturer = $Manufacturer
        $this.Model = $Model
        $this.MaxSpeed = $MaxSpeed
        $this.PS = $PS
        $this.Tires = $Tires
        $this.Type = $Type
    }
    #Methoden
    [void]Drive([int]$Distance)
    {
        [int]$Speed = 0
        [string]$Road ="🚗"

        for($i = 1; $i -le $Distance; $i++)
        {
            $Road = "-" + $Road
            if($Speed -lt $this.MaxSpeed)
            {
                $Speed += 20
            }
            Start-Sleep -Milliseconds (300 - $Speed)
            Clear-Host
            Write-Host -Object $Road -backgroundcolor Black -ForegroundColor White
        }
    }
    # Bestehend Methoden Ã¼berschreiben
    [string]ToString()
    {
        return "Hersteller: $($this.Manufacturer), Modell: $($this.Model), Farbe: $($this.Color), MaxSpeed: $($this.MaxSpeed), PS: $($this.PS), Reifenanzahl: $($this.Tires), Fahrzeugtyp: $($this.Type)"
    }

    [string]ToString([string]$OutputFormat)
    {
        [string]$Ausgabe = ""
        switch ($OutputFormat) {
            CSV { $Ausgabe = $this | ConvertTo-Csv -NoTypeInformation }
            JSON { $Ausgabe = $this | ConvertTo-Json }
            Default {$Ausgabe = $this.ToString()}
        }
        return $Ausgabe
    }
}
<#
#ohne Nutzung Konstruktor
$Auto = [Car]::new()
$Auto.Color = "Black"
$Auto.Manufacturer = "BMW"
$Auto.Model = "330E G21"
$Auto.MaxSpeed = 250
$Auto.PS = 252
$Auto.Tires = 4
$Auto.Type = [VehicleType]::Car
#>

# mit Nutzung Konstruktor
$Auto = [Car]::new("Schwarz", "BMW", "330E G21", 250, 252, 4, [VehicleType]::Car)

$Auto.Drive(75)