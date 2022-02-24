## SRD PR42, 48, 49 when using iOS 15.4_19E5225g | Drilling Down | https://github.com/apple/security-research-device/pull/42

This is a Live Document being updated during the day of THU 24 FEB 2022. There are multiple Versions of macOS and iOS Tested using M1 T8101 & X86_64 shown below, the most recent iOS and macOS shown at bottom.
-----

## SRD Example DMG, PR 42,48,49 Build & Installation Status
| Build OS & Device Info           | Example DMG   |  debugserver DMG  |  ASAN DMG     | UBSAN DMG 
| -------------------------------- | ------------- | ------------- | ------------- | -------------
| macOS 12.2.1 (21D62) X86_64      | PASS          | PASS          | PASS          | FAIL          
| PR 42  19E5235a T8101            | PASS          | PASS          | PASS          | FAIL
| PR 48  19E5235a T8101            | PASS          | PASS          | PASS          | FAIL
| PR 49  19E5235a T8101            | PASS          | PASS          | PASS          | FAIL
| Build macOS 12.3 21E5222a T8101  | PASS          | PASS          | PASS          | FAIL
| Install to iPhone 11 21E5222a    | PASS          | PASS          | PASS          | PASS
| Install to iPhone 12 21E5222a    | PASS          | PASS          | PASS          | PASS 

### SRD Build Unit Tests for ./example-cryptex/ and the *SAN Dylibs

#### Case 1: Build ./example/cryptex/ which includes PR48 + PR49 {updated entitlements and debugserver}
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build.sh)"
```

#### Case 2: Build ./example/cryptex/ and ASAN Dylib linked to hello sample code
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

#### Case 3: Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-ubsan.sh)"
```
### Reproduction Case  1: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 when using iOS 15.4_19E5225g

```
make clean
make install
```
### Results using iPhone 12

```
default	10:22:00.585464-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.USWFhH/usr/bin/debugserver' is adhoc signed.
default	10:22:00.585630-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.USWFhH/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```
### Picture at Left showing the make and install process for ./example-cryptex/ with Picture at Right showing the SRD iPhone 12 Console Log
<img src="https://xss.cx/2022/02/15/img/srd0037-cryptex-install-debugserver-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

## Reproduction Case  2: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 __and__ ASAN Dylib using iPhone 12 when using iOS 15.4_19E5225g

```
default	10:33:07.038976-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/hello[2467] ==> debugserver
default	10:33:07.049099-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver' is adhoc signed.
default	10:33:07.049264-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	10:33:17.064152-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/hello[2470] ==> debugserver
default	10:33:17.074069-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver' is adhoc signed.
default	10:33:17.074337-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.ZKfbpw/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

### Picture at Left showing the make and install process for ./example-cryptex + hello + asan.dylib with Picture at Right showing the SRD iPhone 12 Console Log
<img src="https://xss.cx/2022/02/15/img/srd0037-cryptex-install-hello-ubsan-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log with ASAN" style="height: 800px; width:1000px;"/>

## Reproduction Case 3: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 __and__ UBSAN Dylib using iPhone 12 when using iOS 15.4_19E5225g

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

### Picture at Left showing the make and install process for ./example-cryptex + hello + ubsan.dylib with Picture at Right showing the SRD iPhone 12 Console Log
<img src="https://xss.cx/2022/02/15/img/srd0037-cryptex-install-hello-ubsan-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log with UBSAN" style="height: 800px; width:1000px;"/>

## Deeper Dive into Build & Entitlement Issues using macOS Version 12.3 Beta (21E5206e) on M1 T8101 using iPhone 11 when using iOS 15.4_19E5225g

### SRD Build Unit Tests for ./example-cryptex/ and the *SAN Dylibs

#### Case 1: Build ./example/cryptex/ which includes PR48 + PR49 {updated entitlements and debugserver} when using iOS 15.4_19E5225g
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build.sh)"
```
 
#### Case 2: Build ./example/cryptex/ and ASAN Dylib linked to hello sample code when using iOS 15.4_19E5225g
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

#### Case 3: Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code when using iOS 15.4_19E5225g
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-ubsan.sh)"
```

### Manual Reproduction Case 1: Build the example-cryptex with macOS Version 12.3 Beta (21E5206e) on M1 T8101 

```
make clean
make install
```
### Results using iPhone 11 when using iOS 15.4_19E5225g

```
default	13:12:43.390099-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.4rldXe/usr/bin/debugserver' is adhoc signed.
default	13:12:43.390281-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.4rldXe/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

<img src="https://xss.cx/2022/02/15/img/srd0037-cryptex-install-debugserver-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

### Picture at Left showing the make and install process for ./example-cryptex/ with Picture at Right showing the SRD iPhone 12 Console Log when using iOS 15.4_19E5225g

```
default	13:18:36.008584-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver' is adhoc signed.
default	13:18:36.008703-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

## Reproduction Case  2: Build ./example-cryptex/ and hello sample code with macOS Version 12.3 Beta (21E5206e) on M1 T8101 __and__ ASAN Dylib using iPhone 11 when using iOS 15.4_19E5225g

```
default	13:18:36.008584-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver' is adhoc signed.
default	13:18:36.008703-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	13:18:45.809112-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/hello' is adhoc signed.
default	13:18:45.809300-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/hello': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

<img src="https://xss.cx/2022/02/15/img/srd0009-cryptex-install-hello-asan-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process for ASAN with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

## Reproduction Case 3: Build ./example/cryptex/ and hello sample code with macOS Version 12.3 Beta (21E5206e) on M1 T8101 __and__ UBSAN Dylib using iPhone 11 when using iOS 15.4_19E5225g

```
default	13:41:29.533740-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/hello[5267] ==> debugserver
default	13:41:29.548676-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	13:41:29.559604-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/debugserver' is adhoc signed.
default	13:41:29.559663-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	13:41:39.552968-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/hello[5270] ==> debugserver
default	13:41:39.568058-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	13:41:39.579498-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/debugserver' is adhoc signed.
default	13:41:39.579556-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.SschPE/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

<img src="https://xss.cx/2022/02/15/img/srd0009-cryptex-install-hello-ubsan-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process for UBSAN with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

### macOS 12.2.1 (21D62) on X86_64 on WED 11 FEB 2022 at 1100 US EST for iPhone 11 when using iOS 15.3.1_19D52
#### Case 1: Build ./example/cryptex/ which includes PR48 + PR49 {updated entitlements and debugserver}
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build.sh)"
```

##### Result for Build ./example/cryptex/ on the SRD iPhone 11 when using iOS 15.4_19E5225g - Includes PR48 + PR49

```
default	11:18:56.917251-0500	kernel	hfs: mounted com.example.cryptex.dstroot on device disk2s1
default	11:18:56.927124-0500	MobileStorageMounter	cryptex mount point = <private>
default	11:18:56.927226-0500	MobileStorageMounter	Posting notification: com.apple.mobile.cryptex_mounted
default	11:18:56.929575-0500	installd	0x16afa3000 main_block_invoke_2: event: <OS_xpc_dictionary: <dictionary: 0x105604f50> { count = 4, transaction: 0, voucher = 0x105604480, contents =
	"UserInfo" => <dictionary: 0x10530b5a0> { count = 2, transaction: 0, voucher = 0x0, contents =
		"DiskImageType" => <string: 0x10530b8d0> { length = 7, contents = "Cryptex" }
		"DiskImageMountPath" => <string: 0x1053060e0> { length = 75, contents = "/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS" }
	}
	"Name" => <string: 0x105306640> { length = 35, contents = "com.apple.mobile.disk_image_mounted" }
	"Object" => <string: 0x105305f90> { length = 20, contents = "MobileStorageMounter" }
	"XPCEventName" => <string: 0x10530b4c0> { length = 35, contents = "com.apple.mobile.disk_image_mounted" }
}>
default	11:18:56.952966-0500	installd	0x16afa3000 -[MIDeveloperDiskImageTracker imageMounted:]: received notification: file:///private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/Applications/
default	11:18:56.953097-0500	installd	0x16afa3000 -[MIDeveloperDiskImageTracker checkMountPoint:]_block_invoke: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/Applications is not present now or before
error	11:18:57.031265-0500	kernel	1 duplicate report for Sandbox: MobileStorageMou(519) deny(1) file-read-metadata /private/var/run/com.apple.security.cryptexd/codex.system/live/com.example.cryptex/cpxd
error	11:18:57.031332-0500	kernel	Sandbox: mobile_storage_p(516) deny(1) file-read-metadata /private/var/run/com.apple.security.cryptexd/codex.system/live/com.example.cryptex/cpxd
error	11:18:57.119971-0500	simple-shell	I'm about to listen on fd: 3
default	11:18:57.122471-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/debugserver' is adhoc signed.
default	11:18:57.122595-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
error	11:18:57.123411-0500	simple-server	Hello! I'm simple-server from the example cryptex!
error	11:18:57.123532-0500	simple-server	I'm about to bind to 0.0.0.0:7777
error	11:18:57.123934-0500	simple-server	I'm about to listen on fd: 3
error	11:18:57.124028-0500	simple-server	Waiting for a client to connect...
error	11:18:57.131742-0500	kernel	1 duplicate report for Sandbox: mobile_storage_p(516) deny(1) file-read-metadata /private/var/run/com.apple.security.cryptexd/codex.system/live/com.example.cryptex/cpxd
error	11:18:57.131860-0500	kernel	Sandbox: hello(682) deny(1) file-map-executable /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib
error	11:18:57.134337-0500	dropbear	send failed: Invalid argument
error	11:18:57.134426-0500	dropbear	send failed: Invalid argument
error	11:18:57.134463-0500	dropbear	send failed: Invalid argument
default	11:18:57.135406-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:19:07.146106-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/debugserver' is adhoc signed.
default	11:19:07.146220-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	11:19:07.156826-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.mNUrPS/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
```

### macOS 12.2.1 (21D62) on X86_64 on WED 11 FEB 2022 at 1100 US EST for iPhone 11 when using iOS 15.3.1_19D52
#### Case 2: Build ./example/cryptex/ and ASAN Dylib linked to hello sample code

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

##### Result for Build ./example/cryptex/ and ASAN Dylib linked to hello sample code on the SRD iPhone 11 when using iOS 15.3.1_19D52

```
default	11:14:55.685646-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:14:55.685749-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	11:15:05.669167-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:15:05.705619-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:15:05.705734-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	11:15:15.691719-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:15:15.729199-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:15:15.729290-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.

```

### macOS 12.2.1 (21D62) on X86_64 on WED 11 FEB 2022 at 1100 US EST for iPhone 11 when using iOS 15.3.1_19D52
#### Case 3: Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-ubsan.sh)"
```

##### Result for Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code on the SRD iPhone 11 when using iOS 15.3.1_19D52

```
error	11:09:55.004194-0500	dropbear	send failed: Invalid argument
error	11:09:55.004306-0500	dropbear	send failed: Invalid argument
error	11:09:55.004345-0500	dropbear	send failed: Invalid argument
default	11:09:55.052843-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:10:05.000646-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:10:05.000849-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	11:10:05.017462-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:10:15.030478-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:10:15.030608-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	11:10:15.034358-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:10:25.056121-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:10:25.056224-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:10:25.056391-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	11:10:35.078013-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.ubsan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.ubsan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains<…>'
default	11:10:35.079694-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:10:35.079823-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

### macOS 12.2.1 (21D62) on X86_64 on THU 24 FEB 2022 at 0500 US EST for iPhone 11 when using iOS_15.4_19E5235a
#### Case 1: Build ./example/cryptex/ which includes PR48 + PR49 {updated entitlements and debugserver}
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

##### Result for Build ./example/cryptex/ on macOS 12.2.1 (21D62) on X86_64 using the SRD iPhone 11 with iOS 15.4_19E5225g - Includes PR48 + PR49

PR42
----
```
default	05:52:37.587949-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.YaEcnw/usr/bin/hello' is adhoc signed.
default	05:52:37.588143-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.YaEcnw/usr/bin/hello': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

PR48 + PR49
----
```
default	05:52:37.618797-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.YaEcnw/usr/bin/debugserver' is adhoc signed.
default	05:52:37.618899-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.YaEcnw/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```


#### Case 2: Build ./example/cryptex/ and ASAN Dylib linked to hello sample code for iPhone 11 when using iOS_15.4_19E5235a

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

##### Result for Build ./example/cryptex/ and ASAN Dylib linked to hello sample code on macOS 12.2.1 (21D62) on X86_64 using the SRD iPhone 11 with iOS 15.4_19E5225g

```
error	06:34:51.636460-0500	kernel	1 duplicate report for Sandbox: mobile_storage_p(297) deny(1) file-read-metadata /private/var/run/com.apple.security.cryptexd/codex.system/live/com.example.cryptex/cpxd
error	06:34:51.636548-0500	kernel	Sandbox: hello(930) deny(1) file-map-executable /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib
default	06:34:51.642355-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.asan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.asan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/Xcode<…>'
default	06:35:01.647203-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/debugserver' is adhoc signed.
default	06:35:01.647429-0500	kernel	/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/hello[936] ==> debugserver
default	06:35:01.647537-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	06:35:01.662060-0500	ReportCrash	ASI found [dyld] (sensitive) 'Library not loaded: @rpath/libclang_rt.asan_ios_dynamic.dylib
  Referenced from: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/hello
  Reason: tried: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/13.1.6/lib/darwin/libclang_rt.asan_ios_dynamic.dylib' (no such file), '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib' (file system sandbox blocked mmap() of '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.hDO3oT/usr/bin/libclang_rt.asan_ios_dynamic.dylib'), '/Applications/Xcode-beta.app/Contents/Developer/Toolchains/Xcode<…>'
```

#### Case 3: Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code for iPhone 11 when using iOS_15.4_19E5235a

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-ubsan.sh)"
```

##### Result for Build ./example/cryptex/ and UBSAN Dylib linked to hello sample code on macOS 12.2.1 (21D62) on X86_64 using the SRD iPhone 11 with iOS 15.4_19E5225g

```
default	06:39:40.895462-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.VUuCL7/usr/bin/hello' is adhoc signed.
default	06:39:40.895658-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.VUuCL7/usr/bin/hello': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	06:39:40.916419-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.VUuCL7/usr/bin/debugserver' is adhoc signed.
default	06:39:40.916627-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.VUuCL7/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```
