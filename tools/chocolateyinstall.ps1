﻿
$ErrorActionPreference = 'Stop';

$packageParameters = Get-PackageParameters

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$androidPath = "${Env:SystemDrive}\Android"

# set default installation path if not passed
if (!$packageParameters['InstallationPath']) { $packageParameters['InstallationPath'] = "${androidPath}" }

$installationPath = $packageParameters['InstallationPath']

$url        = 'https://dl.google.com/android/repository/android-ndk-r20-windows-x86.zip'
$url64      = 'https://dl.google.com/android/repository/android-ndk-r20-windows-x86_64.zip'

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

  checksum       = '7541bacd22f5757b9947314ee71111e18fc7db852ac67b23b7dbace229b941cf'
  checksumType   = 'sha256'
  checksum64     = '315cdfdb971ee85a71e267da2cc7d6667ec722c3649aedc45cd42a97b2e8b056'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packagelibPath = $env:ChocolateyPackageFolder

Install-ChocolateyEnvironmentVariable `
  -VariableName 'ANDROID_NDK_ROOT' `
  -VariableValue "$installationPath\$folderName"
