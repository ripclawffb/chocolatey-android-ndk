$url = 'https://dl.google.com/android/repository/android-ndk-r25b-windows.zip'

$zipFileName = Split-Path $url -Leaf

$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  zipFileName = $zipFileName
}

Uninstall-ChocolateyEnvironmentVariable -VariableName 'ANDROID_NDK_ROOT'

Uninstall-ChocolateyZipPackage @packageArgs
