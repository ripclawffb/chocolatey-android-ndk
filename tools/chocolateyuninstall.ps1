$zipFile = 'android-ndk-r19c-windows-x86.zip'
$zipFile64 = 'android-ndk-r19c-windows-x86_64.zip'

If(Get-OSArchitectureWidth -Compare 32) {
  $zipFileName = $zipFile
} Else {
  $zipFileName = $zipFile64
}

$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  zipFileName = $zipFileName
}

$uninstalled = $false

Uninstall-ChocolateyEnvironmentVariable -VariableName 'ANDROID_NDK_ROOT'

Uninstall-ChocolateyZipPackage @packageArgs
