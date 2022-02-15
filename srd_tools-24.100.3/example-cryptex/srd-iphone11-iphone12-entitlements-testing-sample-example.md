## SRD PR42 ASAN & UBSAN Installation Information | Drilling Down | https://github.com/apple/security-research-device/pull/42
###  iPhone 12 - TSS ASAN Cryptex Example HTTP Response of Success for Personalization
```
HTTP/1.1 200 OK
Server: Apple
Date: Sat, 05 Feb 2022 22:13:37 GMT
Content-Type: text/html
Content-Length: 4384
Connection: close
Host: gs.apple.com
Strict-Transport-Security: max-age=31536000; includeSubdomains
X-Frame-Options: SAMEORIGIN

STATUS=0&MESSAGE=SUCCESS&REQUEST_STRING=<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
```
### otool -L hello confirming Link to SAN Lib
```
otool -L com.example.cryptex.dstroot/usr/bin/hello
com.example.cryptex.dstroot/usr/bin/hello:
	@rpath/libclang_rt.asan_ios_dynamic.dylib (compatibility version 0.0.0, current version 0.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1311.100.2)
```
### iPhone 12 - hello with SAN Lib
```
./hello
Hello researcher from pid 953!
```
iPhone 12 debugserver for hello binary with asan dylib
------------
```
(lldb) image dump symtab hello
Symtab, num_symbols = 31:
               Debug symbol
               |Synthetic symbol
               ||Externally Visible
               |||
Index   UserID DSX Type            File Address/Value Load Address       Size               Flags      Name
------- ------ --- --------------- ------------------ ------------------ ------------------ ---------- ----------------------------------
[    0]      0     Code            0x0000000100007bd4 0x000000010432bbd4 0x00000000000001c8 0x001e0080 __os_log_helper_16_0_1_4_0
[    1]      1     Code            0x0000000100007d9c 0x000000010432bd9c 0x0000000000000034 0x000e0000 asan.module_ctor
[    2]      2     Code            0x0000000100007dd0 0x000000010432bdd0 0x000000000000001c 0x000e0000 asan.module_dtor
[    3]      3     Data            0x0000000100007ec0 0x000000010432bec0 0x0000000000000040 0x000e0000 .str
[    4]      4     Data            0x0000000100007f00 0x000000010432bf00 0x0000000000000040 0x000e0000 .str.1
[    5]      5     Data            0x0000000100007f40 0x000000010432bf40 0x0000000000000020 0x000e0000 .str.2
[    6]      6     Data            0x0000000100010000 0x0000000104334000 0x0000000000000040 0x000e0000 __asan_global_.str
[    7]      7     Data            0x0000000100010040 0x0000000104334040 0x0000000000000040 0x000e0000 __asan_global_.str.1
[    8]      8     Data            0x0000000100010080 0x0000000104334080 0x0000000000000040 0x000e0000 __asan_global_.str.2
[    9]      9     Data            0x00000001000100c0 0x00000001043340c0 0x0000000000000010 0x000e0000 __asan_binder_.str
[   10]     10     Data            0x00000001000100d0 0x00000001043340d0 0x0000000000000010 0x000e0000 __asan_binder_.str.1
[   11]     11     Data            0x00000001000100e0 0x00000001043340e0 0x0000000000000010 0x000e0000 __asan_binder_.str.2
[   12]     12     Data            0x00000001000100f0 0x00000001043340f0 0x0000000000000008 0x001e0000 ___asan_globals_registered
[   13]     13   X Data            0x0000000100000000 0x0000000104324000 0x000000000000796c 0x000f0010 _mh_execute_header
[   14]     14   X Code            0x000000010000796c 0x000000010432b96c 0x0000000000000268 0x000f0000 main
[   15]     15     Trampoline      0x0000000100007dec 0x000000010432bdec 0x0000000000000010 0x00010100 __asan_init
[   16]     16   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010100 __asan_option_detect_stack_use_after_return
[   17]     17     Trampoline      0x0000000100007dfc 0x000000010432bdfc 0x0000000000000010 0x00010100 __asan_register_image_globals
[   18]     18     Trampoline      0x0000000100007e0c 0x000000010432be0c 0x0000000000000010 0x00010100 __asan_report_store1
[   19]     19     Trampoline      0x0000000100007e1c 0x000000010432be1c 0x0000000000000010 0x00010100 __asan_report_store4
[   20]     20   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010100 __asan_shadow_memory_dynamic_address
[   21]     21     Trampoline      0x0000000100007e2c 0x000000010432be2c 0x0000000000000010 0x00010100 __asan_stack_malloc_0
[   22]     22     Trampoline      0x0000000100007e3c 0x000000010432be3c 0x0000000000000010 0x00010100 __asan_unregister_image_globals
[   23]     23     Trampoline      0x0000000100007e4c 0x000000010432be4c 0x0000000000000010 0x00010100 __asan_version_mismatch_check_apple_clang_1316
[   24]     24     Trampoline      0x0000000100007e5c 0x000000010432be5c 0x0000000000000010 0x00010200 __stack_chk_fail
[   25]     25   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010200 __stack_chk_guard
[   26]     26     Trampoline      0x0000000100007e6c 0x000000010432be6c 0x0000000000000010 0x00010200 _os_log_impl
[   27]     27     Trampoline      0x0000000100007e7c 0x000000010432be7c 0x0000000000000010 0x00010200 getpid
[   28]     28     Trampoline      0x0000000100007e8c 0x000000010432be8c 0x0000000000000010 0x00010200 os_log_create
[   29]     29     Trampoline      0x0000000100007e9c 0x000000010432be9c 0x0000000000000010 0x00010200 os_log_type_enabled
[   30]     30     Trampoline      0x0000000100007eac 0x000000010432beac 0x0000000000000010 0x00010200 printf
(lldb)
```
### SRD Console Log - iPhone 11
```
Password auth succeeded for 'root' from 192.168.3.83:64608

date
Sat Feb  5 18:53:00 EST 2022

uname -a
Darwin SRD0009 21.4.0 Darwin Kernel Version 21.4.0: Sun Jan 16 20:50:39 PST 2022; root:xnu-8020.100.406.0.1~10/RELEASE_ARM64_T8030 iPhone12,1 Toybox

./debugserver 192.168.3.83:1921 ./hello
debugserver-@(#)PROGRAM:LLDB  PROJECT:lldb-1316.2.4.12
 for arm64.
Listening to port 1921 for a connection from 192.168.3.83...
```
iPhone 11 debugserver for hello binary with asan dylib
---
```
(lldb) image dump symtab hello
Symtab, num_symbols = 31:
               Debug symbol
               |Synthetic symbol
               ||Externally Visible
               |||
Index   UserID DSX Type            File Address/Value Load Address       Size               Flags      Name
------- ------ --- --------------- ------------------ ------------------ ------------------ ---------- ----------------------------------
[    0]      0     Code            0x0000000100007bd4 0x0000000104a07bd4 0x00000000000001c8 0x001e0080 __os_log_helper_16_0_1_4_0
[    1]      1     Code            0x0000000100007d9c 0x0000000104a07d9c 0x0000000000000034 0x000e0000 asan.module_ctor
[    2]      2     Code            0x0000000100007dd0 0x0000000104a07dd0 0x000000000000001c 0x000e0000 asan.module_dtor
[    3]      3     Data            0x0000000100007ec0 0x0000000104a07ec0 0x0000000000000040 0x000e0000 .str
[    4]      4     Data            0x0000000100007f00 0x0000000104a07f00 0x0000000000000040 0x000e0000 .str.1
[    5]      5     Data            0x0000000100007f40 0x0000000104a07f40 0x0000000000000020 0x000e0000 .str.2
[    6]      6     Data            0x0000000100010000 0x0000000104a10000 0x0000000000000040 0x000e0000 __asan_global_.str
[    7]      7     Data            0x0000000100010040 0x0000000104a10040 0x0000000000000040 0x000e0000 __asan_global_.str.1
[    8]      8     Data            0x0000000100010080 0x0000000104a10080 0x0000000000000040 0x000e0000 __asan_global_.str.2
[    9]      9     Data            0x00000001000100c0 0x0000000104a100c0 0x0000000000000010 0x000e0000 __asan_binder_.str
[   10]     10     Data            0x00000001000100d0 0x0000000104a100d0 0x0000000000000010 0x000e0000 __asan_binder_.str.1
[   11]     11     Data            0x00000001000100e0 0x0000000104a100e0 0x0000000000000010 0x000e0000 __asan_binder_.str.2
[   12]     12     Data            0x00000001000100f0 0x0000000104a100f0 0x0000000000000008 0x001e0000 ___asan_globals_registered
[   13]     13   X Data            0x0000000100000000 0x0000000104a00000 0x000000000000796c 0x000f0010 _mh_execute_header
[   14]     14   X Code            0x000000010000796c 0x0000000104a0796c 0x0000000000000268 0x000f0000 main
[   15]     15     Trampoline      0x0000000100007dec 0x0000000104a07dec 0x0000000000000010 0x00010100 __asan_init
[   16]     16   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010100 __asan_option_detect_stack_use_after_return
[   17]     17     Trampoline      0x0000000100007dfc 0x0000000104a07dfc 0x0000000000000010 0x00010100 __asan_register_image_globals
[   18]     18     Trampoline      0x0000000100007e0c 0x0000000104a07e0c 0x0000000000000010 0x00010100 __asan_report_store1
[   19]     19     Trampoline      0x0000000100007e1c 0x0000000104a07e1c 0x0000000000000010 0x00010100 __asan_report_store4
[   20]     20   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010100 __asan_shadow_memory_dynamic_address
[   21]     21     Trampoline      0x0000000100007e2c 0x0000000104a07e2c 0x0000000000000010 0x00010100 __asan_stack_malloc_0
[   22]     22     Trampoline      0x0000000100007e3c 0x0000000104a07e3c 0x0000000000000010 0x00010100 __asan_unregister_image_globals
[   23]     23     Trampoline      0x0000000100007e4c 0x0000000104a07e4c 0x0000000000000010 0x00010100 __asan_version_mismatch_check_apple_clang_1316
[   24]     24     Trampoline      0x0000000100007e5c 0x0000000104a07e5c 0x0000000000000010 0x00010200 __stack_chk_fail
[   25]     25   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010200 __stack_chk_guard
[   26]     26     Trampoline      0x0000000100007e6c 0x0000000104a07e6c 0x0000000000000010 0x00010200 _os_log_impl
[   27]     27     Trampoline      0x0000000100007e7c 0x0000000104a07e7c 0x0000000000000010 0x00010200 getpid
[   28]     28     Trampoline      0x0000000100007e8c 0x0000000104a07e8c 0x0000000000000010 0x00010200 os_log_create
[   29]     29     Trampoline      0x0000000100007e9c 0x0000000104a07e9c 0x0000000000000010 0x00010200 os_log_type_enabled
[   30]     30     Trampoline      0x0000000100007eac 0x0000000104a07eac 0x0000000000000010 0x00010200 printf
(lldb) quit
```
iPhone 11 debugserver for hello binary with ubsan dylib
---
```
(lldb) image dump symtab hello
Symtab, num_symbols = 11:
               Debug symbol
               |Synthetic symbol
               ||Externally Visible
               |||
Index   UserID DSX Type            File Address/Value Load Address       Size               Flags      Name
------- ------ --- --------------- ------------------ ------------------ ------------------ ---------- ----------------------------------
[    0]      0     Code            0x0000000100007e44 0x000000010252fe44 0x0000000000000038 0x001e0080 __os_log_helper_16_0_1_4_0
[    1]      1   X Data            0x0000000100000000 0x0000000102528000 0x0000000000007d08 0x000f0010 _mh_execute_header
[    2]      2   X Code            0x0000000100007d08 0x000000010252fd08 0x000000000000013c 0x000f0000 main
[    3]      3     Trampoline      0x0000000100007e7c 0x000000010252fe7c 0x0000000000000010 0x00010200 __stack_chk_fail
[    4]      4   X Undefined       0x0000000000000000                    0x0000000000000000 0x00010200 __stack_chk_guard
[    5]      5     Trampoline      0x0000000100007e8c 0x000000010252fe8c 0x0000000000000010 0x00010100 __ubsan_handle_nonnull_arg
[    6]      6     Trampoline      0x0000000100007e9c 0x000000010252fe9c 0x0000000000000010 0x00010200 _os_log_impl
[    7]      7     Trampoline      0x0000000100007eac 0x000000010252feac 0x0000000000000010 0x00010200 getpid
[    8]      8     Trampoline      0x0000000100007ebc 0x000000010252febc 0x0000000000000010 0x00010200 os_log_create
[    9]      9     Trampoline      0x0000000100007ecc 0x000000010252fecc 0x0000000000000010 0x00010200 os_log_type_enabled
[   10]     10     Trampoline      0x0000000100007edc 0x000000010252fedc 0x0000000000000010 0x00010200 printf
```
### Process Information Tracing | WIP
SRD
----
```
export CODE_MACH_KMSG_INFO=0x1200028
export CODE_MACH_PROC_EXEC=0x401000C
export CODE_MACH_MSG_SEND=0x120000C
export CODE_MACH_MSG_RECV=0x1200010
export CODE_TRACE_DATA_EXEC=0x7000008
ofile=~/${1:-ipc.raw}
ps -Ac | sed 's,\s*\([0-9][0-9]*\) .*[0-9]*:[0-9]*\.[0-9]* \(.*\), 00000000.0  0.0(0.0)  proc_exec  \1 0 0 0 0 0  \2,' > "${ofile}.txt"

```
## Deeper Dive into Build & Entitlement Issues using macOS 12.2.1 (21D62) on X86_64 using iPhone 12 and IPSW 15.4_19E5219e

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
### Reproduction Case  1: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64

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

## Reproduction Case  2: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 __and__ ASAN Dylib using iPhone 12

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

## Reproduction Case 3: Build the example-cryptex with macOS 12.2.1 (21D62) on X86_64 __and__ UBSAN Dylib using iPhone 12

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

## Deeper Dive into Build & Entitlement Issues using macOS Version 12.3 Beta (21E5206e) on M1 T8101 using iPhone 11 and IPSW 15.4_19E5219e

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

### Manual Reproduction Case 1: Build the example-cryptex with macOS Version 12.3 Beta (21E5206e) on M1 T8101

```
make clean
make install
```
### Results using iPhone 11

```
default	13:12:43.390099-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.4rldXe/usr/bin/debugserver' is adhoc signed.
default	13:12:43.390281-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.4rldXe/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

<img src="https://xss.cx/2022/02/15/img/srd0037-cryptex-install-debugserver-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

### Picture at Left showing the make and install process for ./example-cryptex/ with Picture at Right showing the SRD iPhone 12 Console Log

```
default	13:18:36.008584-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver' is adhoc signed.
default	13:18:36.008703-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

## Reproduction Case  2: Build ./example/cryptex/ and hello sample code with macOS Version 12.3 Beta (21E5206e) on M1 T8101 __and__ ASAN Dylib using iPhone 11

```
default	13:18:36.008584-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver' is adhoc signed.
default	13:18:36.008703-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	13:18:45.809112-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/hello' is adhoc signed.
default	13:18:45.809300-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.3WMvnj/usr/bin/hello': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

<img src="https://xss.cx/2022/02/15/img/srd0009-cryptex-install-hello-asan-ct-rejected-example-001.png" alt="Picture at Left showing the make and install process for ASAN with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

## Reproduction Case 3: Build ./example/cryptex/ and hello sample code with macOS Version 12.3 Beta (21E5206e) on M1 T8101 __and__ UBSAN Dylib using iPhone 11

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
