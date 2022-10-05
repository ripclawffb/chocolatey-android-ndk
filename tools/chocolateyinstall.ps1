
$ErrorActionPreference = 'Stop';

$packageParameters = Get-PackageParameters

$is64bit = Get-ProcessorBits 64

$androidPath = "${Env:SystemDrive}\Android"

# set default installation path if not passed
if (!$packageParameters['InstallationPath']) { $packageParameters['InstallationPath'] = "${androidPath}" }

$installationPath = $packageParameters['InstallationPath']

$url = 'https://dl.google.com/android/repository/android-ndk-r24-windows.zip'

$folderName = (Split-Path $url -Leaf).replace('-windows-x86_64.zip','')

$packageName  = 'android-ndk'
$softwareName = 'android-ndk*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url

  softwareName  = $softwareName

  checksum      = 'b2a9fab1481c3c21df0b78608747dde0747b50890134a62a81c983a5250066d6'
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
