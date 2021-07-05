# Apple Security Research Device (SRD) Repo by SRD0009

Toolchain Details
-----
Makefile https://github.com/xsscx/srd/blob/main/SecurityResearchTools_20C80/usr/local/share/security-research-device/example-cryptex/Makefile

XNU Export
```
export XNU_VERSION=xnu-7195.81.3
```
X86_64
```
sysctl -a | grep Intel
machdep.cpu.brand_string: Intel(R) Core(TM) i5-1038NG7 CPU @ 2.00GHz
```
```
xcode-select -p
/Applications/Xcode.app/Contents/Developer

clang -v
Apple clang version 13.0.0 (clang-1300.0.18.6)
Target: arm64-apple-darwin20.5.0
Thread model: posix
InstalledDir: /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
iOS SDK at /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS14.5.sdk
iOS SDK at /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.0.sdk
```

M1 Apple Silicon
```
sysctl -a | grep M1
machdep.cpu.brand_string: Apple M1
```
```
xcode-select -p
/Applications/Xcode-beta.app/Contents/Developer

clang -v
Apple clang version 13.0.0 (clang-1300.0.18.6)
Target: arm64-apple-darwin20.5.0
Thread model: posix
InstalledDir: /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
iOS SDK at /Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.0.sdk
```
```
iOS SDK 15
iOS SDK 14
iOS 14Beta7
iOS 15Beta2
```
* To ALL - Open a Discussion, PR or Issue with Suggestions, Comments, Bugs, Feedback, Tips etc..
* Collaborative Research
* All Code and Questions are Welcome 
* When you see Code Errors, Fails or LOL's.. Please Open an Issue... Thanks!
 
This is Hoyt's Public Domain & Collaboration Research Code Collection [SRD0009] that is run on an Apple Security Research Device, the Apple SRD.
The Target iOS ranges are 14Beta7 -> 15Beta2. The Target Platform is iPhone 11.

* Industry Participation Requested, See URL https://srd.cx/industry-participation/

* Updated July 4, 2021: Note that Issue #1 is Open and I failed to include the entitlements.plist due to operator error... Now updated

This Repo is Public Domain and I hope you will contribute your Code, Suggestions & Pro Tip's.

The main Focus had been Onboarding the 2021 SRD Cohort with a Working Cryptex and Code Examples, now I want to _your_ input!

--------------------------------------------------
Can someone from Apple (please) look at:

FB9221569 - iOS 15Beta2 and jetsam make Research nearly impossible..  

FB9221261 - debugserver crash - null hostname.. 

FB9223349 - debugserver crash - cryptex cwd.. 

SRD Cohort - See Bug Reports at https://srdcx.atlassian.net/jira/software/c/projects/SRDBUGS/issues/

--------------------------------------------------
Please Contribute Code to be run on the SRD. Results to be Posted rapidly.
--------------------------------------------------

Open an Issue with Details and a Link to your Xcode Project, App or Code and I will attempt to run your Code on the SRD and post Results. Entitlements are the big Hammer to swing with the SRD so include your entitlements.plist.
