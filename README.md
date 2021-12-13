# Welcome to Hoyt's SRD Repo for the Apple Security Research Device
Follow this Repo and https://srd.cx.

```
Latest SRD IPSW 13-DEC-2021: iPhone11,8,iPhone12,1_15.2_19C56_Restore.ipsw
```

Do you have questions or need help? Reach out and open an Issue or Discussion. DM if that's easier.

# Cryptex DMG's for Mainline & Developer Trains
SRD | 19C56 | Signed File: iPhone11,8,iPhone12,1_15.2_19C56_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Customer Erase Install (IPSW)' 

SRD | 19C5044b | Signed File: iPhone11,8,iPhone12,1_15.2_19C5044b_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Developer Erase Install (IPSW)'

See URL https://github.com/xsscx/srd/tree/main/dmg

There are typically 2 DMG's available that are Compiled for the Mainline and Beta Trains.

# What's Here
```
Security Research Tools - Use 20C80 Only
Sample Code for the SRD
Cryptex DMG's built with Toybox Unstripped and includes debugserver, jtool2, binbag, ioscan, ioprint and more...
PoC's on the DMG that Crash, are Broken and Programs that write Hello researcher from pid xxx!
There is a new entitlement called research.com.apple.license-to-operate to support Frida and other research tools for the Apple Security Research Device
```
# Want to write Instrumentation or a PoC for the SRD?

Here is where you start your Instrumentation:
```
groups
wheel daemon kmem sys tty operator procview procmod staff certusers admin
uname -a
Darwin iPhone 21.2.0 Darwin Kernel Version 21.2.0: Tue Oct 19 23:43:56 PDT 2021; root:xnu-8019.60.40.0.1~25/RELEASE_ARM64_T8030 iPhone12,1 Toybox
 whoami
root
```

This Repo is Public Domain and I hope you will contribute your Code, Comments and Suggestions.

SRD Details
----------
```
Model: 		    MWL72LL/A
Model Name:         iPhone 11
release:            21.0.0
version:            Darwin iPhone 21.2.0 Darwin Kernel Version 21.2.0: Tue Oct 19 23:43:56 PDT 2021; root:xnu-8019.60.40.0.1~25/RELEASE_ARM64_T8030 iPhone12,1 Toybox
machine:            iPhone12,1
cpu type:           0x100000c  (arm64e)
cpu subtype:        0x2  (ARM64E)
cpus:               6 cores / 6 threads
memory:             0xf1200000  (3.8G)
page size:          0x4000  (16K)
```
Toolchain Details
-----
Makefile https://github.com/xsscx/srd/blob/main/SecurityResearchTools_20C80/usr/local/share/security-research-device/example-cryptex/Makefile

XNU Export
---
```
export XNU_VERSION=xnu-7195.141.2
```
X86_64
---
```
sysctl -a | grep Intel
machdep.cpu.brand_string: Intel(R) Core(TM) i5-1038NG7 CPU @ 2.00GHz
```
```
clang -v
Apple clang version 13.0.0 (clang-1300.0.29.3)
Target: X86_64-apple-darwin20.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```
M1 Apple Silicon
---
```
sysctl -a | grep M1
machdep.cpu.brand_string: Apple M1
```
```
clang -v
Apple clang version 13.0.0 (clang-1300.0.29.30)
Target: arm64-apple-darwin20.6.0
Thread model: posix
InstalledDir: /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```
SDK Targets
---
```
iOS SDK 15.2
```
Run Targets
---
```
SRD
iPhone 12 Pro Max
iPad 12 Pro
```
How-To Compile for iOS
-----
```
xcrun -sdk iphoneos clang -g -O2  -mios-version-min=14.3 -DDEBUG=0  -Wall -Wpedantic -Wno-gnu -Werror -Wunused-variable -o a.out code.s
```
* To ALL - Open a Discussion, PR or Issue with Suggestions, Comments, Bugs, Feedback, Tips etc..
* Collaborative Research
* All Code and Questions are Welcome 
* When you see Code Errors, Fails or LOL's.. Please Open an Issue... Thanks!

Read about Pointer Authentication Failure at URL https://srd.cx/possible-pointer-authentication-failure-data-abort/

Read about debugserver for SRD at URL https://srd.cx/debugserver-installation-configuration/
