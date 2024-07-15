$ErrorActionPreference = 'Stop';

$unzipLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition        # Get the root of chocolatey folder
$unzipLocation = Join-Path $unzipLocation "$($env:chocolateyPackageName)"     # Append the package's name
$unzipLocation = Join-Path $unzipLocation "$($env:chocolateyPackageVersion)"  # Append the package's version


$extractedDir = Get-ChildItem -Path $unzipLocation | Where-Object { $_.PSIsContainer } | Select-Object -First 1

if (-not $extractedDir) {
    throw "Failed to find the extracted directory."
}

# Define the bin path
$scalaBinPath = Join-Path $unzipLocation $extractedDir | Join-Path -ChildPath 'bin' # Update this path if the structure inside the ZIP changes

# Iterate through the .bat files in the bin directory and create shims
Write-Host "Removing shims for .bat file from $scalaBinPath"
Get-ChildItem -Path $scalaBinPath -Filter '*.bat' | ForEach-Object {
    $file = $_.FullName
    Write-Host "Removing shim for $file..."
    Uninstall-BinFile -Name $_.BaseName -Path $file
}

