$ErrorActionPreference = 'Stop';

$unzipLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'scala'
  Url64         = 'https://github.com/scala/scala3/releases/download/3.5.0-RC3/scala3-3.5.0-RC3-x86_64-pc-win32.zip'
  UnzipLocation = $unzipLocation
}

Install-ChocolateyZipPackage @packageArgs

# Define the bin path
$scalaBinPath = Join-Path $unzipLocation 'scala3-3.5.0-RC3-x86_64-pc-win32' | Join-Path -ChildPath 'bin' # Update this path if the structure inside the ZIP changes

# Iterate through the .bat files in the bin directory and create shims
Write-Host "Creating shims for .bat files in $scalaBinPath..."
Get-ChildItem -Path $scalaBinPath -Filter '*.bat' | ForEach-Object {
    $file = $_.FullName
    Write-Host "Creating shim for $file..."
    Install-BinFile -Name $_.BaseName -Path $file
}
