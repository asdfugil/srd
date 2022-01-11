# toybox mods for Apple SRD by xsscx | M1 T8101 & X86_64 Workarounds 

ADDED: https://github.com/xsscx/srd/tree/main/SecurityResearchTools_21C39/example-cryptex/src/toybox are NET Changes to make toybox compile on iOS 15.x
```
% date
Mon Jan 10 09:53:18 EST 2022
% uname -a
Darwin 20.6.0 Darwin Kernel Version 20.6.0: Wed Nov 10 22:23:05 PST 2021; root:xnu-7195.141.14~1/RELEASE_ARM64_T8101 arm64
```
This is a quick fix for Toybox Build for Apple Security Research Device as of 10 JAN 2022.

Picked Commit https://github.com/landley/toybox/commit/ea4748a7cbfa5e2f3ef188f917d4e5aeac70dd0f

The toybox-src and DMG Build and Install on macOS 11.x and SRT20C80, and the DMG Installs from macOS12.x and SRT21C39 with cryptexctl from libcryptex_executables-169.80.2~9, when TSS isn't experiencing ECID Signing Issues.

This Directory captures the changes used to Roll Back and Build Toybox Unstripped for Apple Secuirty Research Device for all IPSW

Instructions
------
Clone
```
sync to this Repo for SRT 21C39
cd example-cryptex
make install
ssh to SRD
```
Manual
```
Unzip toybox-src.zip in example-cryptex/src that will result in toybox/
cd example-cryptex
make clean
make install
ssh to SRD
```
DMG Install
---
```
Download the DMG
cd example-cryptex
cryptexctl ${CRYPTEXCTL_FLAGS} create --replace ${CRYPTEXCTL_CREATE_FLAGS} -i com.example.cryptex -v 1.3.3.7 ~/Downloads/universal-srd-toybox-unstripped-commit-ea4748a7cbfa5e2f3ef188f917d4e5aeac70dd0f.dmg
cryptexctl ${CRYPTEXCTL_PERSONALIZE_FLAGS} personalize --replace -o com.example.cryptex.cxbd --variant=research com.example.cryptex.cxbd
cryptexctl install --variant=research --persist com.example.cryptex.cxbd.signed
```
# Audit Trail
Toybox Built
----
```
[toybox] - [+++] Installing toybox
Compile instlist...
Generate headers from toys/*/*.c...

warning: using unfinished code from toys/pending
Library probe.............
Make generated/config.h from .config.
generated/flags.h Install commands...
[example-cryptex] - Creating a distribution root: /Users/xss/srd/example-cryptex/com.example.cryptex.dstroot
```
Cryptex Installed using X86_64 and M1 T8101 using macOS 11.6.2 (20G314) and SRT 20C80
---
```
[simple-shell] - [+++] Installing simple-shell
[example-cryptex] - Creating a distribution root: /Users/xss/srd/example-cryptex/com.example.cryptex.dstroot
[toybox] - Checking for macOS SDK at /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.1.sdk
[toybox] - Checking for iOS SDK at /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.2.sdk
[toybox] - Creating SDK header graft...
[toybox] - [+++] Installing toybox
Compile instlist...
Generate headers from toys/*/*.c...

warning: using unfinished code from toys/pending
Library probe.............
Make generated/config.h from .config.
Install commands...
[example-cryptex] - Creating a distribution root: /Users/xss/srd/example-cryptex/com.example.cryptex.dstroot
[welcome] - [+++] Installing welcome
[example-cryptex] - Creating disk image com.example.cryptex.dmg from distribution root /Users/xss/srd/example-cryptex/com.example.cryptex.dstroot
......................................................................................................................
created: /Users/xss/srd/example-cryptex/com.example.cryptex.dmg
[example-cryptex] - Creating cryptex /Users/xss/srd/example-cryptex/com.example.cryptex.cptx - 1.3.3.7 from the disk image com.example.cryptex.dmg
[example-cryptex] - Installing /Users/xss/srd/example-cryptex/com.example.cryptex.cptx onto device: 00008030-001538D03C40012E
com.example.cryptex
  version = 1.3.3.7
  device = /dev/disk2s1
  mount point = /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.qMFb61
```
SSH to SRD
----
```
# date
Mon Jan 10 09:54:44 EST 2022
# uname -a
Darwin iPhone 20.6.0 Darwin Kernel Version 20.6.0: Mon Jun 21 21:23:35 PDT 2021; root:xnu-7195.140.42~10/RELEASE_ARM64_T8030 iPhone12,1 Toybox
#
```

Questions? Add to https://github.com/xsscx/srd/issues/7