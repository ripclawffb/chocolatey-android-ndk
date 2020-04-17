#  Android NDK Chocolatey Package

[![Build status](https://ci.appveyor.com/api/projects/status/swe3r4sxl683pvwo/branch/master?svg=true)](https://ci.appveyor.com/project/ripclawffb/chocolatey-android-ndk/branch/master)

The Native Development Kit (NDK) is a set of tools that allows you to use C and C++ code with Android, and provides platform libraries you can use to manage native activities and access physical device components, such as sensors and touch input. The NDK may not be appropriate for most novice Android programmers who need to use only Java code and framework APIs to develop their apps. However, the NDK can be useful for cases in which you need to do one or more of the following:

* Squeeze extra performance out of a device to achieve low latency or run computationally intensive applications, such as games or physics simulations.
* Reuse your own or other developers' C or C++ libraries.

**Please Note:** Due to the way Google versions their android-ndk package, it is not compatible with the NuGet spec. So to get around it, I've replaced the letter variant to a dot number notation.
Examples: 
* `r19` is equivalent to 19.0
* `r19c` is equivalent to 19.3

### Package Specific
#### Package Parameters
The following package parameters can be set:

* `/InstallationPath:` - Where to install the package to - defaults to "`$env:SystemDrive\Android\`"

To pass parameters, use `--params "''"` (e.g. `choco install packageID [other options] --params="'/ITEM:value /ITEM2:value2 /FLAG_BOOLEAN'"`).
To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.