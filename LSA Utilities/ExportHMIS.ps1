# Parameters
$server = "SQUAREPEG"
$database = "HMIS"
$viewListPath = "C:\Users\MollyMcEvilley\OneDrive - Square Peg Data\GitHub\LSASampleCodev8\LSA Utilities\HMISViewList.csv"

# Read the view/output pairs
$views = Import-Csv -Path $viewListPath -Header ViewName,OutputFile

Remove-Item -Path "C:\Users\MollyMcEvilley\OneDrive - Square Peg Data\GitHub\LSASampleCodev8\Sample Data\Sample HMIS Data\*" -Force

foreach ($entry in $views) {
    $view = $entry.ViewName
    $output = $entry.OutputFile
    Write-Host "Exporting $view to $output..."

    # Extract just the table name for INFORMATION_SCHEMA query
    $tableName = $view
    if ($tableName -like "*.*") {
        $tableName = $tableName.Split('.')[-1].Trim('[]')
    }

    # Get column names for header row
    $colNames = Invoke-Sqlcmd -ServerInstance $server -Database $database `
        -Query "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tableName'" `
        -TrustServerCertificate | Select-Object -ExpandProperty COLUMN_NAME
    $header = $colNames -join ","
    Set-Content -Path $output -Value $header

    # Compose the sqlcmd command (no headers, no separator lines)
    $sql = "SET NOCOUNT ON; SELECT * FROM $view"
    $sqlcmdArgs = @(
        "-S", $server,
        "-d", $database,
        "-E",             # Windows Authentication
        "-C",             # TrustServerCertificate
        "-Q", $sql,
        "-s", ",",
        "-W",
        "-h", "-1",
        "-b"
    )

    # Capture output as array, then append to file
    $dataLines = & sqlcmd.exe @sqlcmdArgs
    if ($dataLines) {
        Add-Content -Path $output -Value $dataLines
    }
}

Compress-Archive -Path "C:\Users\MollyMcEvilley\OneDrive - Square Peg Data\GitHub\LSASampleCodev8\Sample Data\Sample HMIS Data\*.*" -Update "C:\Users\MollyMcEvilley\OneDrive - Square Peg Data\GitHub\LSASampleCodev8\Sample Data\Sample HMIS Data.zip"

Write-Host "Export and compression completed."