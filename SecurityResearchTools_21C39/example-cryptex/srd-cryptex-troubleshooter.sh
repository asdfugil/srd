#!/bin/sh
echo "SRD Cryptex Troubleshooter Log Collector Start"
echo "umount com.example.cryptex"
cryptexctl uninstall com.example.cryptex
date > srd-cryptex-troubleshooter.log
uname -a >> srd-cryptex-troubleshooter.log
clang -v >> srd-cryptex-troubleshooter.log
cryptexctl version >> srd-cryptex-troubleshooter.log
sysctl -a | grep brand >> srd-cryptex-troubleshooter.log
csrutil status >> srd-cryptex-troubleshooter.log
cryptexctl -v2 -d2  install --variant=research --persist --print-info ./com.example.cryptex.cxbd.signed
echo "Check for cryptex install"
cryptexctl list
# sudo sysdiagnose
cat srd-cryptex-troubleshooter.log
echo "SRD Cryptex Troubleshooter Log Collector End"