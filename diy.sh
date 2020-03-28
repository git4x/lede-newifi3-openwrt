#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# 更改默认主题为Argon
cd lede/package/lean  
rm -rf luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' package/feeds/luci/luci/Makefile
make menuconfig
# Modify default IP
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate
#Clash
git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash
#修复Clash随OpenWrt官方源码一起编译出现的依赖冲突
#sed -i 's/+luci +luci-base //' package/luci-app-clash/Makefile
# OpenClash
git clone https://github.com/vernesong/OpenClash.git package/mine/OpenClash
# 管控上网行为
git clone https://github.com/destan19/OpenAppFilter.git package/mine/OpenAppFilter
# disable usb3.0
git clone https://github.com/rufengsuixing/luci-app-usb3disable.git package/mine/luci-app-usb3disable

./scripts/feeds update -a
./scripts/feeds install -a
