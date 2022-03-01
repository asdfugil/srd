## SRD PR42

There are multiple Versions of macOS and iOS Tested using M1 T8101 & X86_64 shown below, the most recent iOS and macOS shown at bottom. Apple needs to Resolve the AMFI | CoreTrust issues for the SRD. Debugging Tools like Frida and debugserver need the correct Entitlements from Apple to work as expected and provide provable data. 

## SRD Example DMG, PR 42,48,49 Build & Installation Status
| Build OS & Device Info           | Example DMG   |  debugserver DMG  |  ASAN DMG     | UBSAN DMG 
| -------------------------------- | ------------- | ------------- | ------------- | -------------
| macOS 12.2.1 (21D62) X86_64      | PASS          | PASS          | PASS          | PASS          
| PR 42  19E5235a T8101            | PASS          | PASS          | PASS          | PASS 
| PR 48  19E5235a T8101            | PASS          | PASS          | PASS          | PASS 
| PR 49  19E5235a T8101            | PASS          | PASS          | PASS          | PASS 
| Build macOS 12.3 21E5222a T8101  | PASS          | PASS          | PASS          | PASS 
| Install to iPhone 11 21E5222a    | PASS          | PASS          | PASS          | PASS
| Install to iPhone 12 21E5222a    | PASS          | PASS          | PASS          | PASS 

### Entitlement Issues with CoreTrust | AMFI research

Fiddle 'n Twiddle the Magic Bits
-------
```
hexdump -n 4 /Users/xss/example-cryptex/com.example.cryptex.dstroot/usr/bin/hello
0000000 cf fa ed fe
```
Next, change the magic bits, rebuild the DMG, Install the cryptex and watch your SRD Console Log, Search == cryptex
```
hexdump -n 4 /Users/xss/example-cryptex/com.example.cryptex.dstroot/usr/bin/hello
0000000 ca fe ba be
```
### AMFI Complaint
```
default	17:58:05.812913-0500	MobileStorageMounter	cryptex mount point = <private>
default	17:58:05.813328-0500	MobileStorageMounter	Posting notification: com.apple.mobile.cryptex_mounted
default	17:58:05.814496-0500	installd	0x16b223000 main_block_invoke_2: event: <OS_xpc_dictionary: <dictionary: 0x105205500> { count = 4, transaction: 0, voucher = 0x105206730, contents =
	"UserInfo" => <dictionary: 0x105206db0> { count = 2, transaction: 0, voucher = 0x0, contents =
		"DiskImageType" => <string: 0x105205330> { length = 7, contents = "Cryptex" }
		"DiskImageMountPath" => <string: 0x105207170> { length = 75, contents = "/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt" }
	}
	"Name" => <string: 0x105205ae0> { length = 35, contents = "com.apple.mobile.disk_image_mounted" }
	"Object" => <string: 0x105205b10> { length = 20, contents = "MobileStorageMounter" }
	"XPCEventName" => <string: 0x105206c50> { length = 35, contents = "com.apple.mobile.disk_image_mounted" }
}>
default	17:58:05.840151-0500	installd	0x16b223000 -[MIDeveloperDiskImageTracker imageMounted:]: received notification: file:///private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/Applications/
default	17:58:05.840190-0500	installd	0x16b223000 -[MIDeveloperDiskImageTracker checkMountPoint:]_block_invoke: /private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/Applications is not present now or before
error	17:58:05.882616-0500	kernel	1 duplicate report for Sandbox: MobileStorageMou(257) deny(1) file-read-metadata /private/var/run/com.apple.security.cryptexd/codex.system/live/com.example.cryptex/cpxd
error	17:58:05.882647-0500	kernel	Sandbox: mobile_storage_p(255) deny(1) file-read-metadata /private/var/run/com.apple.security.cryptexd/codex.system/live/com.example.cryptex/cpxd
error	17:58:05.996618-0500	simple-server	Hello! I'm simple-server from the example cryptex!
error	17:58:05.996860-0500	simple-server	I'm about to bind to 0.0.0.0:7777
error	17:58:05.997100-0500	simple-server	I'm about to listen on fd: 3
error	17:58:05.997172-0500	simple-server	Waiting for a client to connect...
error	17:58:06.006463-0500	simple-shell	I'm about to listen on fd: 3
error	17:58:06.008274-0500	dropbear	send failed: Invalid argument
error	17:58:06.008343-0500	dropbear	send failed: Invalid argument
error	17:58:06.008388-0500	dropbear	send failed: Invalid argument
default	17:58:06.022066-0500	debugserver	debugserver will use ASL for internal logging.
default	17:58:06.022135-0500	debugserver	debugserver-@(#)PROGRAM:LLDB  PROJECT:lldb-1316.2.4.16
 for arm64.
default	17:58:06.022167-0500	debugserver	Listening to port 2345 for a connection from 0.0.0.0...
default	18:03:08.004506-0500	dropbear	Password auth succeeded for 'root' from 192.168.3.83:52544
default	18:03:08.026880-0500	dropbear	CRYPTEX_SHELL specified. User shell is now '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/sh'
default	18:03:08.029665-0500	dropbear	Setting PATH to '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/sbin:/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/bin:/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin:/sbin:/bin:/usr/bin'
default	18:03:08.031774-0500	dropbear	Starting shell: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/sh'
default	18:03:08.048146-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/toybox' is adhoc signed.
default	18:03:08.048203-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/toybox': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	18:03:13.841078-0500	dropbear	Password auth succeeded for 'root' from 192.168.3.83:52545
default	18:03:13.860867-0500	dropbear	CRYPTEX_SHELL specified. User shell is now '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/sh'
default	18:03:13.863580-0500	dropbear	Setting PATH to '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/sbin:/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/bin:/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin:/sbin:/bin:/usr/bin'
default	18:03:13.865431-0500	dropbear	Starting shell: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/sh'
default	18:03:13.867017-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/toybox' is adhoc signed.
default	18:03:13.867125-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.anYnBt/usr/bin/toybox': unsuitable CT policy 0 for this platform/device, rejecting signature.
```
#### Comment
```
If you've gotten this far, you too probably realize this is a long-cycle problem for Resolution.
```

### CoreTrust | AMFI | Magic Number | Platform | Errors

```
2022-03-01 11:49:37.356385-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:hdi] mntfd fd[11]: type = S_IFDIR, size = 64, flags = <private>, path = <private>
2022-03-01 11:49:37.385362-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: building trust cache from: <private>
2022-03-01 11:49:37.385686-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.385954-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.386010-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.386024-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.386044-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.386193-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.386224-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.386235-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.386251-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.386372-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.386403-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.386416-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.386448-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.386632-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.386655-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.386767-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.386917-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.387150-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.387171-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.387240-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.387339-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.387572-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.387605-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.387619-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.387667-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.387866-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not a mach binary: 0x6d783f3c: [92: Illegal byte sequence]
2022-03-01 11:49:37.387891-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:dyld-cache] [anonymous]: not a dyld shared cache: <private>: [88: Malformed Mach-o file]
2022-03-01 11:49:37.387945-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: not a shared cache
2022-03-01 11:49:37.391652-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.396193-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 18
    sizeofcmds = 1240
    flags = 0x200085
2022-03-01 11:49:37.396250-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.396262-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.396272-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.396282-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.396291-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.396302-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.396312-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.396320-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.396368-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.396393-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.396410-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.396453-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.396488-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.396586-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.396715-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.396767-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.396817-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.396856-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.396909-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 66656
    cmd->datasize = 19504
2022-03-01 11:49:37.397113-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.397130-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 909
2022-03-01 11:49:37.397140-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 909
2022-03-01 11:49:37.397171-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.397230-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.397273-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.397328-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 17
2022-03-01 11:49:37.397364-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.397392-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.397429-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.397442-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.397476-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.397491-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.397581-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.397688-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.402822-0500 0xfec8f    Error       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: fat file: 0xbebafeca: [79: Inappropriate file type or format]
2022-03-01 11:49:37.402864-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: initialized fat header:
        magic = 0xcafebabe
        nfat = 2
2022-03-01 11:49:37.402876-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: fat file has 2 archs
2022-03-01 11:49:37.402912-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: found slice: off = 16384, length = 638016
2022-03-01 11:49:37.402955-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0
    file type = 0x2
    ncmds = 33
    sizeofcmds = 3560
    flags = 0x218085
2022-03-01 11:49:37.402972-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.402982-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.402991-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.403002-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.403062-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.403090-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.403167-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.403206-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.403272-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.403315-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.403358-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.403415-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.403497-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.403546-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.403566-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403587-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403607-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403628-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403678-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403703-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403745-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403802-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403849-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403897-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403954-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403973-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.403994-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.404015-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.404092-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.404102-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.404118-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.404148-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.404170-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.404193-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 613312
    cmd->datasize = 24704
2022-03-01 11:49:37.409515-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.409596-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 5134
2022-03-01 11:49:37.409619-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 5134
2022-03-01 11:49:37.409676-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.409728-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.409742-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.409768-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 32
2022-03-01 11:49:37.409828-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.409848-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.409884-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.409985-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.410048-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.410123-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.410166-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.410232-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: found slice: off = 655360, length = 658032
2022-03-01 11:49:37.410739-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 33
    sizeofcmds = 3720
    flags = 0x218085
2022-03-01 11:49:37.410774-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.410795-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.410817-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.410834-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.410853-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.410871-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.410888-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.410960-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.411048-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.411120-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.411198-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.411217-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.411271-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.411325-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.411408-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411445-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411489-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411522-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411596-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411648-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411672-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411705-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411759-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411787-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411804-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411877-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.411979-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.412008-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.412084-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.412123-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.412211-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.412312-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.412389-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.412410-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 633168
    cmd->datasize = 24864
2022-03-01 11:49:37.412851-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.412884-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 5294
2022-03-01 11:49:37.412902-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 5294
2022-03-01 11:49:37.413001-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.413047-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.413071-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.413094-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 32
2022-03-01 11:49:37.413116-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.413135-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.413168-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.413268-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.413330-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.413416-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.413490-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.413712-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.420448-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 19
    sizeofcmds = 1792
    flags = 0x200085
2022-03-01 11:49:37.420473-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.420506-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.420515-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.420523-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.420532-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.420540-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.420548-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.420556-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.420588-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.420639-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.420672-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.420741-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.420801-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.420813-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.420822-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.420851-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.420879-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.420908-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.420991-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.421017-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 352080
    cmd->datasize = 21792
2022-03-01 11:49:37.421171-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.421186-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 3114
2022-03-01 11:49:37.421195-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 3114
2022-03-01 11:49:37.421214-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.421227-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.421237-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.421268-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 18
2022-03-01 11:49:37.421307-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.421323-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.421343-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.421364-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.421386-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.421478-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.421514-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.421562-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.426484-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 23
    sizeofcmds = 2728
    flags = 0x200085
2022-03-01 11:49:37.426529-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.426548-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.426575-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.426585-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.426593-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.426601-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.426609-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.426617-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.426652-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.426735-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.426798-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.426879-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.426899-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.426986-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.427060-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.427112-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.427191-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.427208-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.427266-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.427322-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.427389-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.427464-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.427534-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.427618-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 5747376
    cmd->datasize = 82736
2022-03-01 11:49:37.427810-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.427826-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 45271
2022-03-01 11:49:37.427835-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 45271
2022-03-01 11:49:37.428139-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.428160-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.428171-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.428204-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 22
2022-03-01 11:49:37.428221-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.428230-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.428237-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.428245-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.428252-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.428276-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.428334-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.428404-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.428564-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 18
    sizeofcmds = 1240
    flags = 0x200085
2022-03-01 11:49:37.428580-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.428590-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.428618-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.428664-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.428715-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.428757-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.428802-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.428820-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.428901-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.428926-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.428994-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.429026-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.429036-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.429056-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.429076-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.429096-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.429134-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.429174-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.429206-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 66192
    cmd->datasize = 18800
2022-03-01 11:49:37.429316-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 36
2022-03-01 11:49:37.429330-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 743
2022-03-01 11:49:37.429339-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 743
2022-03-01 11:49:37.429390-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.429408-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.429476-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.429497-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 17
2022-03-01 11:49:37.429568-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 36
2022-03-01 11:49:37.429624-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.429707-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.429769-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 3
2022-03-01 11:49:37.429841-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.429935-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.430132-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 21
    sizeofcmds = 1576
    flags = 0x200085
2022-03-01 11:49:37.430150-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.430160-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.430208-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.430261-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.430327-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.430413-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.430473-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.430525-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.430577-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.430641-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.430695-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.430744-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.430803-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.430863-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.430917-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.430959-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.431005-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.431057-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.431123-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.431167-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.431213-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.431266-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 54016
    cmd->datasize = 18704
2022-03-01 11:49:37.431387-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 36
2022-03-01 11:49:37.431399-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 647
2022-03-01 11:49:37.431407-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 647
2022-03-01 11:49:37.431472-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.431532-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.431578-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.431629-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 20
2022-03-01 11:49:37.431690-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 36
2022-03-01 11:49:37.431739-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.431784-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.431835-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 3
2022-03-01 11:49:37.431890-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.431949-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.432103-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 18
    sizeofcmds = 1240
    flags = 0x200085
2022-03-01 11:49:37.432117-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.432126-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.432134-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.432186-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.432230-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.432290-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.432333-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.432375-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.432420-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.432477-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.432518-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.432568-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.432615-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.432677-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.432739-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.432756-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.432814-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.432836-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.432903-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 66864
    cmd->datasize = 19504
2022-03-01 11:49:37.433054-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.433074-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 911
2022-03-01 11:49:37.433100-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 911
2022-03-01 11:49:37.433200-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.433241-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.433280-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.433367-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 17
2022-03-01 11:49:37.433400-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.433420-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.433479-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.433517-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.433552-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.433591-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.433669-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.433744-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.433905-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 18
    sizeofcmds = 1240
    flags = 0x200085
2022-03-01 11:49:37.433942-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.433970-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.433982-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.433994-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.434039-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.434102-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.434143-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.434218-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.434261-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.434371-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.434453-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.434535-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.434610-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.434625-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.434696-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.434738-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.434768-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.434821-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.434918-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 67248
    cmd->datasize = 19504
2022-03-01 11:49:37.435136-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.435157-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 910
2022-03-01 11:49:37.435170-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 910
2022-03-01 11:49:37.435204-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.435219-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.435266-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.435288-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 17
2022-03-01 11:49:37.435377-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.435422-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.435444-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.435504-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.435595-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.435610-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.435656-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.435701-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.435953-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x2
    ncmds = 23
    sizeofcmds = 1920
    flags = 0x200085
2022-03-01 11:49:37.435976-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.435989-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.435998-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.436006-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.436014-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.436022-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.436031-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.436039-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.436047-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.436076-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xe
2022-03-01 11:49:37.436126-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.436158-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.436180-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.436209-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000028
2022-03-01 11:49:37.436231-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.436260-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.436306-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.436321-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.436353-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.436408-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.436447-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.436479-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.436523-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.436587-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 380752
    cmd->datasize = 22048
2022-03-01 11:49:37.436680-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 52
2022-03-01 11:49:37.436693-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 2, csid offset = 88, length = 3336
2022-03-01 11:49:37.436702-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 3336
2022-03-01 11:49:37.436721-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.436748-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.436762-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.436775-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 22
2022-03-01 11:49:37.436803-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 52
2022-03-01 11:49:37.436824-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.436849-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x5
2022-03-01 11:49:37.436894-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x7
2022-03-01 11:49:37.436906-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.436935-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 5
2022-03-01 11:49:37.436960-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.437123-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: found regular file: <private>
2022-03-01 11:49:37.437255-0500 0xfec8f    Error       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: fat file: 0xbebafeca: [79: Inappropriate file type or format]
2022-03-01 11:49:37.437275-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: initialized fat header:
        magic = 0xcafebabe
        nfat = 2
2022-03-01 11:49:37.437285-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: fat file has 2 archs
2022-03-01 11:49:37.437295-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: found slice: off = 16384, length = 19677696
2022-03-01 11:49:37.437307-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0
    file type = 0x6
    ncmds = 15
    sizeofcmds = 1872
    flags = 0x100085
2022-03-01 11:49:37.437317-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.437325-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.437334-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.437375-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xd
2022-03-01 11:49:37.437431-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000022
2022-03-01 11:49:37.437490-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.437519-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.437568-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.437614-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x25
2022-03-01 11:49:37.437652-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.437679-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.437693-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.437715-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.437745-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.437756-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.437793-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 19412640
    cmd->datasize = 265056
2022-03-01 11:49:37.440748-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 44
2022-03-01 11:49:37.440766-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 1, csid offset = 88, length = 94951
2022-03-01 11:49:37.440781-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 1, length = 94951
2022-03-01 11:49:37.445679-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.445705-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.445717-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.445728-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 14
2022-03-01 11:49:37.445739-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 44
2022-03-01 11:49:37.445747-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.445755-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0x1000, off = 95179
2022-03-01 11:49:37.445763-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 2, hash type = 2, csid offset = 88, length = 151855
2022-03-01 11:49:37.445771-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 151855
2022-03-01 11:49:37.446642-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.446666-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.446676-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.446686-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 14
2022-03-01 11:49:37.446696-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 2, type = 0, off = 44
2022-03-01 11:49:37.446704-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.446712-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 2, last idx = 2, type = 0x1000, off = 95179
2022-03-01 11:49:37.446719-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.446726-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 4
2022-03-01 11:49:37.446735-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.446753-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-fat] [anonymous]: found slice: off = 19709952, length = 20267616
2022-03-01 11:49:37.446977-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: initialized header:
    magic = 0xfeedfacf
    cpu type = 0x100000c
    cpu subtype = 0x80000002
    file type = 0x6
    ncmds = 17
    sizeofcmds = 1944
    flags = 0x100085
2022-03-01 11:49:37.447000-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.447012-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.447022-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.447030-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x19
2022-03-01 11:49:37.447038-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xd
2022-03-01 11:49:37.447046-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000034
2022-03-01 11:49:37.447054-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x80000033
2022-03-01 11:49:37.447062-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2
2022-03-01 11:49:37.447070-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xb
2022-03-01 11:49:37.447089-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x1b
2022-03-01 11:49:37.447113-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x32
2022-03-01 11:49:37.447130-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2a
2022-03-01 11:49:37.447147-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x2c
2022-03-01 11:49:37.447200-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0xc
2022-03-01 11:49:37.447221-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x26
2022-03-01 11:49:37.447264-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: not code signature: 0x29
2022-03-01 11:49:37.447288-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: found
    ldcmd->cmd = 0x1d
    ldcmd->cmdsize = 16
2022-03-01 11:49:37.447307-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: parsing
    cmd->cmd = 0x1d
    cmd->cmdsize = 16
    cmd->dataoff = 19995168
    cmd->datasize = 272448
2022-03-01 11:49:37.449446-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0, off = 44
2022-03-01 11:49:37.449478-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 0, hash type = 1, csid offset = 88, length = 97791
2022-03-01 11:49:37.449489-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 1, length = 97791
2022-03-01 11:49:37.450014-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.450041-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.450052-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.450065-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 16
2022-03-01 11:49:37.450075-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 0, type = 0, off = 44
2022-03-01 11:49:37.450084-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.450091-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] found code directory: type = 0x1000, off = 98019
2022-03-01 11:49:37.450099-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] read code directory header: idx = 2, hash type = 2, csid offset = 88, length = 156399
2022-03-01 11:49:37.450108-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] reading code directory: hash type = 2, length = 156399
2022-03-01 11:49:37.450885-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] computed digest: <private>
2022-03-01 11:49:37.450909-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code signing identity: <private>
2022-03-01 11:49:37.450926-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] code directory: identity = <private>, hash = <private>
2022-03-01 11:49:37.450943-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: extracted cdhash: cmd = 0x1d, idx = 16
2022-03-01 11:49:37.450959-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 0, last idx = 2, type = 0, off = 44
2022-03-01 11:49:37.450974-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x2
2022-03-01 11:49:37.450988-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] previously-encountered code directory: superblob idx = 2, last idx = 2, type = 0x1000, off = 98019
2022-03-01 11:49:37.451002-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] not a code directory: 0x10000
2022-03-01 11:49:37.451012-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] exhausted cs blobs: cnt = 4
2022-03-01 11:49:37.451073-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:mach-object] [anonymous]: no more cs blobs
2022-03-01 11:49:37.451394-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote module header: <private>
2022-03-01 11:49:37.451421-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451432-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451440-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451478-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451515-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451707-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451841-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451890-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451935-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.451965-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.452013-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.452036-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.452093-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.452120-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:trust-cache] [anonymous]: wrote cdhash: <private>
2022-03-01 11:49:37.452282-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:utility] wrote 358 bytes
2022-03-01 11:49:37.452631-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:utility] wrote 311 bytes
2022-03-01 11:49:37.465798-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:cryptex] [anonymous]: setting name: <private>
2022-03-01 11:49:37.465847-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:cryptex.core] [anonymous]: setting name: <private>
2022-03-01 11:49:37.465934-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex_core.dylib) [com.apple.libcryptex:cryptex.core] <private>: core has research dmg asset
2022-03-01 11:49:37.466051-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex_core.dylib) [com.apple.libcryptex:cryptex.core] <private>: no asset of type: im4m
2022-03-01 11:49:37.466108-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex_core.dylib) [com.apple.libcryptex:cryptex.core] <private>: no asset of type: pdmg
2022-03-01 11:49:37.466161-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: identity: bord = 0xc, chip = 0x8101, sdom = 0x1
2022-03-01 11:49:37.466204-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: variant: <private>
2022-03-01 11:49:37.466243-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding asset: type = cpxd, name = <private>
2022-03-01 11:49:37.466280-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding asset: type = ltrs, name = (null)
2022-03-01 11:49:37.466327-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding asset: type = c411, name = (null)
2022-03-01 11:49:37.466359-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:cryptex] <private>: no asset of type: im4m
2022-03-01 11:49:37.466393-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: skip adding internal asset root
2022-03-01 11:49:37.466428-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:cryptex] <private>: no asset of type: pdmg
2022-03-01 11:49:37.466518-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding build identity:
<private>
2022-03-01 11:49:37.466546-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding cryptex bundle asset: <private>
2022-03-01 11:49:37.466573-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding cryptex bundle asset: <private>
2022-03-01 11:49:37.466594-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: adding cryptex bundle asset: <private>
2022-03-01 11:49:37.466626-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:bundle] [anonymous]: skip adding internal asset root
2022-03-01 11:49:37.466923-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: (libcryptex.dylib) [com.apple.libcryptex:utility] wrote 1047 bytes
2022-03-01 11:49:37.490096-0500 0xfec8f    Error       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:utility] renameat: [66: Directory not empty]
2022-03-01 11:49:37.490477-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:utility] renameat succeeded
2022-03-01 11:49:37.490681-0500 0xfec8f    Debug       0x0                  65665  0    cryptexctl.research: [com.apple.libcryptex:utility] renameat succeeded
```

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
#### Case 2: Build ./example/cryptex/ which includes PR48 + PR49 {updated entitlements and debugserver}
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xsscx/srd/main/srd_tools-24.100.3/example-cryptex/build-asan.sh)"
```

### Result == Works
```
(lldb) image dump sections
Dumping sections for 2 modules.
Sections for '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.pU5TsF/usr/bin/hello(0x00000001029c8000)' (arm64e):
  SectID     Type             Load Address                             Perm File Off.  File Size  Flags      Section Name
  ---------- ---------------- ---------------------------------------  ---- ---------- ---------- ---------- ----------------------------
  0x00000100 container        [0x0000000000000000-0x0000000100000000)* ---  0x00000000 0x00000000 0x00000000 hello.__PAGEZERO
  0x00000200 container        [0x00000001029c8000-0x00000001029d4000)  r-x  0x00000000 0x0000c000 0x00000000 hello.__TEXT
  0x00000001 code             [0x00000001029cf96c-0x00000001029cfdec)  r-x  0x0000796c 0x00000480 0x80000400 hello.__TEXT.__text
  0x00000002 code             [0x00000001029cfdec-0x00000001029cfebc)  r-x  0x00007dec 0x000000d0 0x80000408 hello.__TEXT.__auth_stubs
  0x00000003 regular          [0x00000001029cfebc-0x00000001029cfec0)  r-x  0x00007ebc 0x00000004 0x00000016 hello.__TEXT.__init_offsets
  0x00000004 regular          [0x00000001029cfec0-0x00000001029cff60)  r-x  0x00007ec0 0x000000a0 0x00000000 hello.__TEXT.__asan_cstring
  0x00000005 data-cstr        [0x00000001029cff60-0x00000001029cff8f)  r-x  0x00007f60 0x0000002f 0x00000002 hello.__TEXT.__cstring
  0x00000006 regular          [0x00000001029cff8f-0x00000001029cff97)  r-x  0x00007f8f 0x00000008 0x00000000 hello.__TEXT.__const
  0x00000007 compact-unwind   [0x00000001029cff98-0x00000001029cffe8)  r-x  0x00007f98 0x00000050 0x00000000 hello.__TEXT.__unwind_info
  0x00000008 data-cstr        [0x00000001029d0000-0x00000001029d001e)  r-x  0x00008000 0x0000001e 0x00000002 hello.__TEXT.__oslogstring
  0x00000300 container        [0x00000001029d4000-0x00000001029d8000)  rw-  0x0000c000 0x00004000 0x00000010 hello.__DATA_CONST
  0x00000009 data-ptrs        [0x00000001029d4000-0x00000001029d4068)  rw-  0x0000c000 0x00000068 0x00000006 hello.__DATA_CONST.__auth_got
  0x0000000a data-ptrs        [0x00000001029d4068-0x00000001029d4080)  rw-  0x0000c068 0x00000018 0x00000006 hello.__DATA_CONST.__got
  0x0000000b data-ptrs        [0x00000001029d4080-0x00000001029d4088)  rw-  0x0000c080 0x00000008 0x0000000a hello.__DATA_CONST.__mod_term_func
  0x0000000c regular          [0x00000001029d4088-0x00000001029d40b8)  rw-  0x0000c088 0x00000030 0x00000000 hello.__DATA_CONST.__const
  0x00000400 container        [0x00000001029d8000-0x00000001029dc000)  rw-  0x00010000 0x00004000 0x00000000 hello.__DATA
  0x0000000d regular          [0x00000001029d8000-0x00000001029d80c0)  rw-  0x00010000 0x000000c0 0x00000000 hello.__DATA.__asan_globals
  0x0000000e regular          [0x00000001029d80c0-0x00000001029d80f0)  rw-  0x000100c0 0x00000030 0x00000000 hello.__DATA.__asan_liveness
  0x0000000f zero-fill        [0x00000001029d80f0-0x00000001029d80f8)  rw-  0x00000000 0x00000000 0x00000001 hello.__DATA.__common
  0x00000500 container        [0x00000001029dc000-0x00000001029e4000)  r--  0x00014000 0x00005150 0x00000000 hello.__LINKEDIT
Sections for '/Users/xss/Library/Developer/Xcode/iOS DeviceSupport/15.4 (19E5225g) arm64e/Symbols/usr/lib/dyld' (arm64e):
  SectID     Type             Load Address                             Perm File Off.  File Size  Flags      Section Name
  ---------- ---------------- ---------------------------------------  ---- ---------- ---------- ---------- ----------------------------
  0x00000100 container        [0x0000000102b7c000-0x0000000102bd4000)  r-x  0x00000000 0x00058000 0x00000000 dyld.__TEXT
  0x00000001 code             [0x0000000102b7d000-0x0000000102bca3bc)  r-x  0x00001000 0x0004d3bc 0x80000400 dyld.__TEXT.__text
  0x00000002 regular          [0x0000000102bca3c0-0x0000000102bcb2f0)  r-x  0x0004e3c0 0x00000f30 0x00000000 dyld.__TEXT.__const
  0x00000003 data-cstr        [0x0000000102bcb2f0-0x0000000102bd385a)  r-x  0x0004f2f0 0x0000856a 0x00000002 dyld.__TEXT.__cstring
  0x00000004 compact-unwind   [0x0000000102bd385c-0x0000000102bd3b70)  r-x  0x0005785c 0x00000314 0x00000000 dyld.__TEXT.__unwind_info
  0x00000200 container        [0x0000000102bd4000-0x0000000102be8000)  rw-  0x00058000 0x00014000 0x00000010 dyld.__DATA_CONST
  0x00000005 regular          [0x0000000102bd4000-0x0000000102bd4070)  rw-  0x00058000 0x00000070 0x00000000 dyld.__DATA_CONST.__auth_ptr
  0x00000006 regular          [0x0000000102bd4070-0x0000000102bd7c98)  rw-  0x00058070 0x00003c28 0x00000000 dyld.__DATA_CONST.__const
  0x00000007 regular          [0x0000000102bd7c98-0x0000000102be7c98)  rw-  0x0005bc98 0x00010000 0x00000000 dyld.__DATA_CONST.__bss
  0x00000300 container        [0x0000000102be8000-0x0000000102bec000)  rw-  0x0006c000 0x00004000 0x00000000 dyld.__DATA
  0x00000008 data             [0x0000000102be8000-0x0000000102be813c)  rw-  0x0006c000 0x0000013c 0x00000000 dyld.__DATA.__data
  0x00000009 regular          [0x0000000102be8140-0x0000000102be82b0)  rw-  0x0006c140 0x00000170 0x00000000 dyld.__DATA.__all_image_info
  0x0000000a regular          [0x0000000102be82b0-0x0000000102be82f0)  rw-  0x0006c2b0 0x00000040 0x00000000 dyld.__DATA.__crash_info
  0x0000000b zero-fill        [0x0000000102be8300-0x0000000102be9cf8)  rw-  0x00000000 0x00000000 0x00000001 dyld.__DATA.__common
  0x0000000c zero-fill        [0x0000000102be9cf8-0x0000000102bea1dc)  rw-  0x00000000 0x00000000 0x00000001 dyld.__DATA.__bss
  0x00000400 container        [0x0000000102bec000-0x0000000102c24000)  r--  0x00070000 0x000356f0 0x00000000 dyld.__LINKEDIT
```

#### Results for UBSAN dylib and hello.c example
```
default	10:07:52.191668-0500	debugserver	debugserver will use ASL for internal logging.
default	10:07:52.191746-0500	debugserver	debugserver-@(#)PROGRAM:LLDB  PROJECT:lldb-1316.2.4.16
 for arm64.
default	10:07:52.191785-0500	debugserver	Listening to port 2345 for a connection from 0.0.0.0...
default	10:08:02.176695-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.LCIv75/usr/bin/hello' is adhoc signed.
default	10:08:02.176819-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.LCIv75/usr/bin/hello': unsuitable CT policy 0 for this platform/device, rejecting signature.
default	10:08:12.190854-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.LCIv75/usr/bin/hello' is adhoc signed.
default	10:08:12.190975-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.LCIv75/usr/bin/hello': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

## Observation

AMFI Research complains about __debugserver__:
```
default	11:10:35.079694-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver' is adhoc signed.
default	11:10:35.079823-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.7rGwkO/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

## SAT 26 FEB 2022 Spot Check - debugserver not working - iPhone 12

```
default	10:10:51.684679-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.y2awNR/usr/bin/debugserver' is adhoc signed.
default	10:10:51.684818-0500	kernel	AMFI: '/private/var/run/com.apple.security.cryptexd/mnt/com.example.cryptex.y2awNR/usr/bin/debugserver': unsuitable CT policy 0 for this platform/device, rejecting signature.
```

### Visual Representation of the Issue(s) - below, debugserver causing AMFI to throw() on iPhone 11

<img src="https://xss.cx/2022/02/25/img/srd0009-iphone11-debugserver-adhoc_signed-ct-coretrust-rejected-amfi_research-example-001.png" alt="Picture at Left showing the make and install process for debugserver with Picture at Right showing the SRD iPhone 11 Console Log" style="height: 800px; width:1000px;"/>

### Visual Representation of the Issue(s) - below, debugserver causing AMFI to throw() on iPhone 12

<img src="https://xss.cx/2022/02/25/img/srd0037-iphone12-debugserver-adhoc_signed-ct-coretrust-rejected-amfi_research-example-001.png" alt="Picture at Left showing the make and install process for debugserver with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

## SAT 26 FEB 2022 Spot Check - ubsan working iPhone 12

<img src="https://xss.cx/2022/02/25/img/srd0037-ubsan-working-macos_1221_example-no-entitlements-sample-001.png" alt="Picture at Left showing the make and install process for debugserver with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>


## SAT 26 FEB 2022 Spot Check - asan working iPhone 12

<img src="https://xss.cx/2022/02/25/img/srd0037-asan-working-macos_1221_example-no-entitlements-sample-001.png" alt="Picture at Left showing the make and install process for debugserver with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>


## SAT 26 FEB 2022 Spot Check - ubsan _not_ working iPhone 12

<img src="https://xss.cx/2022/02/25/img/srd0037-ubsan-not_working-macos_1221_example-no-entitlements-sample-001.png" alt="Picture at Left showing the make and install process for debugserver with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>

## MON 28 FEB 2022 Spot Check - asan working iPhone 11

<img src="https://xss.cx/2022/02/28/img/srd0009-applesecurityresearchdevice-debugserver-amfi-research-working-entitlement-example-001.png" alt="Picture at Left showing the make and install process for debugserver with Picture at Right showing the SRD iPhone 12 Console Log" style="height: 800px; width:1000px;"/>
