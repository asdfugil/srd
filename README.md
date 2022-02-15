# Welcome to Hoyt's SRD Repo
MON 14 FEB 2022 at 1700 US EST
## SRD DMG Install
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/dmg/install.sh)"
```
This SRD Example DMG Repo is __1 PR__ https://github.com/apple/security-research-device/pull/42 _ahead_ of https://github.com/apple/security-research-device/tree/main/example-cryptex and _includes_ PR https://github.com/apple/security-research-device/pull/48 and PR https://github.com/apple/security-research-device/pull/49.
## SRD Example DMG, PR 42,48,49 Build & Installation Status
| Build OS & Device Info           | Example DMG   |  debugserver DMG  |  ASAN DMG     | UBSAN DMG 
| -------------------------------- | ------------- | ------------- | ------------- | -------------
| macOS 12.2.1 (21D62) X86_64      | PASS          | PASS          | PASS          | PASS          
| PR 42  21E5206e T8101            | PASS          | PASS          | PASS          | PASS
| PR 48  21E5206e T8101            | FAIL          | FAIL          | FAIL          | FAIL
| PR 49  21E5206e T8101            | FAIL          | FAIL          | FAIL          | FAIL
| Build macOS 12.3 21E5206e T8101  | PASS          | PASS          | PASS          | PASS
| Install to iPhone 11 19E5219e    | PASS          | PASS          | PASS          | PASS
| Install to iPhone 12 19E5219e    | PASS          | PASS          | PASS          | PASS 
## Prerequisites 
- Security Research Tools https://github.com/apple/security-research-device
## Resources
- Source: https://github.com/apple/security-research-device/tree/main/example-cryptex
- PR42: https://github.com/apple/security-research-device/pull/42
- Universal DMG: https://xss.cx/srd/dmg/srd-universal-cryptex.dmg
- ASAN Beta DMG: https://xss.cx/srd/dmg/srd-asan-cryptex-beta.dmg
- UBSAN Beta DMG: https://xss.cx/srd/dmg/srd-ubsan-cryptex-beta.dmg
- Install: https://github.com/xsscx/srd/tree/main/dmg#readme
- Discussion: nvram settings disabling KTRR, CTRR and kASLR https://github.com/apple/security-research-device/discussions/2
- IPSW & Cryptex Installations 
    -  Build Info, Issue Tracker
    -  Summary & Workarounds 
    -  iPhone 11 & 12 SRD Models 
- Pre-built DMG's for the Apple Security Research Device 
    - toyboxunstripped
    - frida
    - debugserver
    - Sample PoC's from CVE's
        - Chain3
        - P0 PoC's
            - Stage 0,1,2
            - port_refs
        - ZecOps 
            - iOS 13 + 14 Voucher Leak 
- Sample Code
    - Example ASAN Makefile and Binary
    - Example UBSAN Makefile and Binary
    - Example Code Coverage Makefile and Binary
    - Example libarchive.a
    - Example aslr Binary
    - Example Binaries in /bin
# SRD DMG Testing
- Universal cryptex for iPhone 11 and iPhone 12 SRD Models 
- Tested on the iPhone 11 for all IPSW from the iOS 14.3 floor for the iPhone 11 up to the latest iOS 15.4 Beta 
- Tested on the iPhone 12 for all IPSW from the iOS 15.2 floor for the iPhone 12 up to the latest iOS 15.4 Beta
- Tested on macOS 11.6.x using SRT 20C80, macOS 12.x using 21C39 and Cryptex Manager from X86_64 and M1 T8101 Platforms 

SRD Cryptex Log Collector
---
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/SecurityResearchTools_21C39/example-cryptex/srd-cryptex-troubleshooter.sh)"
```
# Lastest IPSW + Cryptex Installations 
```
Signed File: iPhone11,8,iPhone12,1_15.3_19D50_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Customer Erase Install (IPSW)' 
Signed File: iPhone13,2,iPhone13,3_15.3_19D50_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Customer Erase Install (IPSW)'
Signed File: iPhone12,8,iPhone12,1_15.4_19E5219e_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Developer Erase Install (IPSW)'
Signed File: iPhone13,2,iPhone13,3_15.4_19E5219e_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Developer Erase Install (IPSW)'
```
The above means that from X86_64 and/or M1 ARM the SRD IPSW has been installed with cryptex personalization verified as shown below.

Makefile
-----
21C39 https://github.com/xsscx/srd/blob/main/SecurityResearchTools_21C39/example-cryptex/Makefile

XNU Export
---
```
export XNU_VERSION=xnu-7195.141.2
```
# Hosts
X86_64
---
```
sysctl -a | grep CPU
machdep.cpu.brand_string: Intel(R) Core(TM) i7-8700B CPU @ 3.20GHz
```
```
clang -v
Apple clang version 13.1.6 (clang-1316.0.20.6)
Target: x86_64-apple-darwin21.3.0
InstalledDir: /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```
M1 Apple Silicon
---
```
sysctl -a | grep M1
machdep.cpu.brand_string: Apple M1
```
```
clang -v
Apple clang version 13.1.6 (clang-1316.0.20.6)
Target: arm64-apple-darwin21.4.0
InstalledDir: /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```
SDK Targets
---
```  
 SDK Path: "/Users/xss/Library/Developer/Xcode/iOS DeviceSupport/15.4 (19E5209h) arm64e"
 SDK Roots: [ 0] "Developer/Xcode/iOS DeviceSupport/15.3 (19D49) arm64e"
 SDK Roots: [ 1] "Developer/Xcode/iOS DeviceSupport/15.3 (19D50) arm64e"
 SDK Roots: [ 2] "Developer/Xcode/iOS DeviceSupport/14.7.1 (18G82) arm64e"
 SDK Roots: [ 3] "Developer/Xcode/iOS DeviceSupport/15.4 (19E5209h) arm64e"
 SDK Roots: [ 4] "Developer/Xcode/iOS DeviceSupport/15.2.1 (19C63) arm64e"
 SDK Roots: [ 5] "Developer/Xcode/iOS DeviceSupport/14.8 (18H17) arm64e"
 SDK Roots: [ 6] "Developer/Xcode/iOS DeviceSupport/15.3 (19D5026g) arm64e"
 SDK Roots: [ 7] "eveloper/Xcode/iOS DeviceSupport/15.2 (19C56) arm64e"
```
Run Targets
---
```
SRD's - iPhone 11 and iPhone 12
iPhone 12 Pro Max
iPad 12 Pro
```
How-To Compile for iOS
-----
```
xcrun -sdk iphoneos clang -g -O2  -mios-version-min=14.3 -DDEBUG=0  -Wall -Wpedantic -Wno-gnu -Werror -Wunused-variable -o a.out code.s
```

## Deeper Dive into Build & Entitlement Issues using macOS 12.2.1 (21D62) on X86_64 using iPhone 12 with 15.4_19E5219e
Sun Feb 13 17:28:48 EST 2022
```
kern.version: Darwin Kernel Version 21.3.0: Wed Jan  5 21:37:58 PST 2022; root:xnu-8019.80.24~20/RELEASE_X86_64
kern.osversion: 21D62
kern.iossupportversion: 15.3
kern.osproductversion: 12.2.1
kern.osproductversioncompat: 10.16
kern.osproductversioncompat: 10.16
/Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
udid                           name       build      BORD       CHIP       ECID
00008030-001538D03C40012E      SRD0009    19E5219e   0x4        0x8030     0x1538d03c40012e
00008101-001418DA3CC0013A      SRD0037    19E5219e   0xc        0x8101     0x1418da3cc0013a
Apple clang version 13.1.6 (clang-1316.0.20.6)
Target: x86_64-apple-darwin21.3.0
InstalledDir: /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
Darwin Cryptex Management Interface Version 2.0.0: Sun Dec 19 22:28:12 PST 2021; root:libcryptex_executables-169.80.2~9/cryptexctl/WEN_ETA_X86_64
machdep.cpu.brand_string: Intel(R) Core(TM) i7-8700B CPU @ 3.20GHz
System Integrity Protection status: disabled.
```

### SRD Build Unit Tests for ./example-cryptex/ and the *SAN Dylibs

#### Build ./example/cryptex/ which includes PR48 + PR49 {updated entitlements and debugserver}
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build.sh)"
```

#### Build ./example/cryptex/ and ASAN Dylib linked to hello sample code
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

#### Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-ubsan.sh)"
```
### Manual Reproduction Case #1: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64  using iPhone 12

```
make clean
make install
```
### Results using iPhone 12

```
default	10:22:00.585464-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.USWFhH/usr/bin/debugserver' is adhoc signed.
default	10:22:00.585630-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.USWFhH/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```
### Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log
<img src="https://xss.cx/2022/02/15/img/srd0037-cryptex-install-debugserver-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

## Reproduction Case #2: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 __and__ ASAN Dylib using iPhone 12

```
default	10:33:07.038976-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/hello[2467] ==> debugserver
default	10:33:07.049099-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver' is adhoc signed.
default	10:33:07.049264-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	10:33:17.064152-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/hello[2470] ==> debugserver
default	10:33:17.074069-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver' is adhoc signed.
default	10:33:17.074337-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

## Reproduction Case #3: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 __and__ UBSAN Dylib using iPhone 12

```
error	10:37:14.650327-0500	kernel	Sandbox: hello(2520) deny(1) file-map-executable /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib
default	10:37:14.653177-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	10:37:24.659471-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/debugserver' is adhoc signed.
default	10:37:24.659594-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	10:37:24.660537-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/hello[2529] ==> debugserver
default	10:37:24.672394-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.sYr3Iw/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'

```


* To ALL - Open a Discussion, PR or Issue with Suggestions, Comments, Bugs, Feedback, Tips etc..
* Collaborative Research
* All Code and Questions are Welcome 
* When you see Code Errors, Fails or LOL's.. Please Open an Issue... Thanks!

Read about Pointer Authentication Failure at URL https://srd.cx/possible-pointer-authentication-failure-data-abort/

Read about debugserver for SRD at URL https://srd.cx/debugserver-installation-configuration/

Follow this Repo and read URL https://srd.cx/srd-cryptex-installation/

