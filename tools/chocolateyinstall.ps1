
$ErrorActionPreference = 'Stop';

$packageParameters = Get-PackageParameters

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$androidPath = "${Env:SystemDrive}\Android"

# set default installation path if not passed
if (!$packageParameters['InstallationPath']) { $packageParameters['InstallationPath'] = "${androidPath}" }

$installationPath = $packageParameters['InstallationPath']

$url        = 'https://dl.google.com/android/repository/android-ndk-r16b-windows-x86.zip'
$url64      = 'https://dl.google.com/android/repository/android-ndk-r16b-windows-x86_64.zip'

If(Get-OSArchitectureWidth -Compare 32) {
  $zipFileName = Split-Path $url -Leaf
} Else {
  $zipFileName = Split-Path $url64 -Leaf
}

If(Get-OSArchitectureWidth -Compare 32) {
  $folderName = (Split-Path $url -Leaf).replace('-windows-x86.zip','')
} Else {
  $folderName = (Split-Path $url64 -Leaf).replace('-windows-x86_64.zip','')
}

$packageName = 'android-ndk'
$softwareName = 'android-ndk*'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $installationPath
  url            = $url
  url64bit       = $url64

  softwareName   = $softwareName

  checksum       = 'a67c1152eda390de715e1cdb53b1e5959bcebf233a02326dc0193795c6eda8d7'
  checksumType   = 'sha256'
  checksum64     = '4c6b39939b29dfd05e27c97caf588f26b611f89fe95aad1c987278bd1267b562'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packagelibPath = $env:ChocolateyPackageFolder

Install-ChocolateyEnvironmentVariable `
  -VariableName 'ANDROID_NDK_ROOT' `
  -VariableValue "$installationPath\$folderName"
