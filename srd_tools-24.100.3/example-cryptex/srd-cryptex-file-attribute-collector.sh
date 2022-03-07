#!/bin/sh
echo "=========================================="
echo "SRD Cryptex File Profile Collector Start"
echo "=========================================="
echo "Collecting Info"
date > srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/cryptex-run >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/cryptex-run >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/cryptex-run >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/cryptex-run >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/cryptex-run >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/cryptex-run >> srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/debugserver >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/debugserver >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/debugserver >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/debugserver >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/debugserver >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/debugserver >> srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/frida >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/frida >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/frida >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/frida >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/frida >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/frida >> srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/nvram >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/nvram >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/nvram >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/nvram >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/nvram >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/nvram >> srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/simple-server >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/simple-server >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/simple-server >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/simple-server >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/simple-server >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/simple-server >> srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/simple-shell >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/simple-shell >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/simple-shell >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/simple-shell >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/simple-shell >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/simple-shell >> srd-cryptex-file-attribute-collector.log 2>&1
codesign --display --entitlements - --xml com.example.cryptex.dstroot/usr/bin/toybox >> srd-cryptex-file-attribute-collector.log 2>&1
codesign -dvvv /Users/xss/example-cryptex/toybox >> srd-cryptex-file-attribute-collector.log 2>&1
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/toybox >> srd-cryptex-file-attribute-collector.log 2>&1
otool -L  com.example.cryptex.dstroot/usr/bin/toybox >> srd-cryptex-file-attribute-collector.log 2>&1
xcrun dyldinfo -rebase -bind  com.example.cryptex.dstroot/usr/bin/toybox >> srd-cryptex-file-attribute-collector.log 2>&1
machodump -i com.example.cryptex.dstroot/usr/bin/toybox >> srd-cryptex-file-attribute-collector.log 2>&1
echo "=========================================="
echo "SRD Cryptex File Profile Collector Stop"
echo "=========================================="
