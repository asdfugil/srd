#!/bin/sh
echo "Printing the Magic Numbers for the default ./example-cryptex/ ... "
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/hello
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/toybox
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/simple-shell
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/simple-server
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/nvram
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/debugserver
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/cryptex-run
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/frida-server
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/libclang_rt.asan_ios_dynamic.dylib
hexdump -n 4 com.example.cryptex.dstroot/usr/lib/frida/frida-agent.dylib
