
$ErrorActionPreference = 'Stop';

$packageParameters = Get-PackageParameters

$is64bit = Get-ProcessorBits 64

$androidPath = "${Env:SystemDrive}\Android"

# set default installation path if not passed
if (!$packageParameters['InstallationPath']) { $packageParameters['InstallationPath'] = "${androidPath}" }

$installationPath = $packageParameters['InstallationPath']

$url = 'https://dl.google.com/android/repository/android-ndk-r26d-windows.zip'

$folderName = (Split-Path $url -Leaf).replace('-windows-x86_64.zip','')

$packageName  = 'android-ndk'
$softwareName = 'android-ndk*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url

  softwareName  = $softwareName

  checksum      = '9b285da57a36818cb65ea5b93ec74f8138f48a40182ff2994f6aade4580ed597'
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
