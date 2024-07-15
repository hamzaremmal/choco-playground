$ErrorActionPreference = 'Stop';

$unzipLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'scala'
  Url64         = 'https://github.com/scala/scala3/releases/download/3.5.0-RC3/scala3-3.5.0-RC3-x86_64-pc-win32.zip'
  UnzipLocation = $unzipLocation
}

Install-ChocolateyZipPackage @packageArgs
