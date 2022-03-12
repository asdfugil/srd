### Contribute to the iPhone 11 & iPhone 12 Register Fuzzing Project
-Note that this Summar Page will Update Frequently with Results 

Reference: M1 Apple Silicon SPRR Permission Checks https://github.com/xsscx/macos-research/tree/main/sprr

This Public Domain Repo is meant to Document the Results of Testing the iPhone 12,1 Registers. 

DATAPOINT: https://gist.github.com/bazad/42054285391c6e0dcd0ede4b5f969ad2

DATAPOINT: https://github.com/xsscx/srd/blob/main/code/registers/data/iphone11-registers-s3-cleaned-uniq-fuzz-input-001.txt

DATAPOINT: https://github.com/gdelugre/ida-arm-system-highlight/blob/master/highlight_arm_system_insn.py

October 25, 2021: In iOS 15.1 Apple added a new entitlement called research.com.apple.license-to-operate to support Frida and other research tools for the Apple Security Research Device. This entitlement allows tools to bypass the PPL codesigning protections and the usual task-port policies to inject code into any process running on the system (platform and non-platform).

In Progress Testing as of SAT 12 MAR 2022 for iPhone 11 SRD
------
```
s3_5_c15_c10_1      : 0x0000000000000000
s3_6_c15_c1_6       : 0x2020000030200000
```

In Progress Testing as of SAT 12 MAR 2022 for iPhone 12 SRD
------
```
s3_4_c15_c10_5 can READ
s3_5_c15_c10_1 can READ
s3_6_c15_c1_5 can READ
```
