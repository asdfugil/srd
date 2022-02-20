# Welcome to Hoyt's SRD Repo
TUE 15 FEB 2022 at 1540 US EST
## SRD DMG Install
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/dmg/install.sh)"
```
This SRD Example DMG Repo is __1 PR__ https://github.com/apple/security-research-device/pull/42 _ahead_ of https://github.com/apple/security-research-device/tree/main/example-cryptex and _includes_ PR https://github.com/apple/security-research-device/pull/48 and PR https://github.com/apple/security-research-device/pull/49.
## SRD Example DMG, PR 42,48,49 Build & Installation Status when using iOS 15.4_19E5225g
| Build OS & Device Info           | Example DMG   |  debugserver DMG  |  ASAN DMG     | UBSAN DMG 
| -------------------------------- | ------------- | ------------- | ------------- | -------------
| macOS 12.2.1 (21D62) X86_64      | PASS          | FAIL          | FAIL          | FAIL          
| PR 42  19E5225g T8101            | PASS          | FAIL          | FAIL          | FAIL
| PR 48  19E5225g T8101            | FAIL          | FAIL          | FAIL          | FAIL
| PR 49  19E5225g T8101            | FAIL          | FAIL          | FAIL          | FAIL
| Build macOS 12.3 19E5225g T8101  | PASS          | FAIL          | FAIL          | FAIL
| Install to iPhone 11 19E5225g    | PASS          | PASS          | PASS          | PASS
| Install to iPhone 12 19E5225g    | PASS          | PASS          | PASS          | PASS 

Apple needs to Resolve the Issues with PR https://github.com/apple/security-research-device/pull/48 & PR https://github.com/apple/security-research-device/pull/49. For a deeper dive see https://github.com/xsscx/srd/blob/main/srd_tools-24.100.3/example-cryptex/srd-iphone11-iphone12-entitlements-testing-sample-example.md. Entitlement & Build Issues are normal, with each IPSW, there is the potential for breaking changes and the Workaround is to keep SRT 20C80 available, and/or use CryptexManager https://github.com/pinauten/CryptexManager.

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
- Build  Entitlements Issues for PR 42, 48, 49 https://github.com/xsscx/srd/blob/main/srd_tools-24.100.3/example-cryptex/srd-iphone11-iphone12-entitlements-testing-sample-example.md
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
Signed File: iPhone12,8,iPhone12,1_15.4_19E5225g_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Developer Erase Install (IPSW)'
Signed File: iPhone13,2,iPhone13,3_15.4_19E5225g_Restore.ipsw | defaults write com.apple.AMPDevicesAgent ipsw-variant -string 'Research Developer Erase Install (IPSW)'
```
The above means that from X86_64 and/or M1 ARM the SRD IPSW has been installed with cryptex personalization verified as shown below.

Makefile
-----
https://github.com/xsscx/srd/blob/main/srd_tools-24.100.3/example-cryptex/Makefile

XNU Export
---
```
export XNU_VERSION=xnu-7195.141.2
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

When using a regexp to find Console Log Messages, these Files may be helpful:
- https://github.com/xsscx/srd/blob/main/code/xnu-os-cli-regexp-small-applesecurityresearchdevice-runtarget-001.txt
- https://github.com/xsscx/Commodity-Injection-Signatures/blob/master/meta/xnu-os-cli-regexp-small-applesecurityresearchdevice-runtarget-002.txt

If you experience a Crash when using cryptexctl or com.apple.cryptex*, these URL's may be helpful:
- https://srd.cx/possible-pointer-authentication-failure-data-abort/
- https://srd.cx/debugserver-installation-configuration/

* To ALL - Open a Discussion, PR or Issue with Suggestions, Comments, Bugs, Feedback, Tips etc..
* Collaborative Research
* All Code and Questions are Welcome 
* When you see Code Errors, Fails or LOL's.. Please Open an Issue... Thanks!

