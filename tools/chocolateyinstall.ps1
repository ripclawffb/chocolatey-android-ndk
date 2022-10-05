
$ErrorActionPreference = 'Stop';

$packageParameters = Get-PackageParameters

$is64bit = Get-ProcessorBits 64

$androidPath = "${Env:SystemDrive}\Android"

# set default installation path if not passed
if (!$packageParameters['InstallationPath']) { $packageParameters['InstallationPath'] = "${androidPath}" }

$installationPath = $packageParameters['InstallationPath']

$url = 'https://dl.google.com/android/repository/android-ndk-r25b-windows.zip'

$folderName = (Split-Path $url -Leaf).replace('-windows-x86_64.zip','')

$packageName  = 'android-ndk'
$softwareName = 'android-ndk*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url

  softwareName  = $softwareName

  checksum      = 'c9a72beda4663ab714c9fb3dc06bb9b9f124f2b5199957c86cd6f57eb59fd49a'
  checksumType  = 'sha256'
}

if ($is64bit) {
  Install-ChocolateyZipPackage @packageArgs

  Install-ChocolateyEnvironmentVariable `
    -VariableName 'ANDROID_NDK_ROOT' `
    -VariableValue "$installationPath\$folderName"
} else {
  throw $_.Exception
}
