#!/bin/sh
echo "Starting Magic Number Sample...."
echo "hello"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/hello
echo "toybox"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/toybox
echo "simple-shell"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/simple-shell
echo "simple-server"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/simple-server
echo "nvram"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/nvram
echo "debugserver"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/debugserver
echo "cryptex-run"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/cryptex-run
echo "frida-server"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/frida-server
echo "ubsan"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/libclang_rt.ubsan_ios_dynamic.dylib
echo "asan"
hexdump -n 4 com.example.cryptex.dstroot/usr/bin/libclang_rt.asan_ios_dynamic.dylib
echo "frida-dylib"
hexdump -n 4 com.example.cryptex.dstroot/usr/lib/frida/frida-agent.dylib
