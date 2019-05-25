
$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$androidPath = "${Env:SystemDrive}\Android"
$destination = "${androidPath}"
$url        = 'https://dl.google.com/android/repository/android-ndk-r19c-windows-x86.zip'
$url64      = 'https://dl.google.com/android/repository/android-ndk-r19c-windows-x86_64.zip'

If(Get-OSArchitectureWidth -Compare 32) {
  $zipFileName = $url.split('/')[-1]
} Else {
  $zipFileName = $url64.split('/')[-1]
}

If(Get-OSArchitectureWidth -Compare 32) {
  $folderName = $url.split('/')[-1].replace('-windows-x86.zip','')
} Else {
  $folderName = $url64.split('/')[-1].replace('-windows-x86_64.zip','')
}


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $destination
  url           = $url
  url64bit      = $url64

  softwareName  = 'android-ndk*'

  checksum      = '800C3C6BA616DDF25097D43566D5D574F9E6C0A10538BF60DD5BE0E024F732CD'
  checksumType  = 'sha256'
  checksum64    = '0FAF708C9837A921CAE5262745F5857162614BB9689A0D188780D12EA93A2C18'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packagelibPath = $env:ChocolateyPackageFolder

Rename-Item -Path "$destination\$folderName" -NewName "$destination\$($packageArgs.softwareName.replace('*',''))"
((Get-Content -path "$packagelibPath\$($zipFileName).txt" -Raw) -replace "$($destination.replace("\","\\"))\\$folderName","$destination\$($packageArgs.softwareName.replace('*',''))") | Set-Content -Path "$packagelibPath\$($zipFileName).txt"











    








