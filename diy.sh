#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
#修改机器名称
sed -i 's/OpenWrt/newifi3/g' package/base-files/files/bin/config_generate
# Modify default IP
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate
#Clash
git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash
#修复Clash随OpenWrt官方源码一起编译出现的依赖冲突
#sed -i 's/+luci +luci-base //' package/luci-app-clash/Makefile
# 管控上网行为
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# disable usb3.0
git clone https://github.com/rufengsuixing/luci-app-usb3disable.git package/luci-app-usb3disable
# 更改默认主题为Argon
sed -i 's/config internal themes/config internal themes\n    option Argon  \"\/luci-static\/argon\"/g' feeds/luci/modules/luci-base/root/etc/config/luci
#去除默认bootstrap主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
cd package/lean  
rm -rf luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  
cd ..
cd ..
./scripts/feeds update -a
./scripts/feeds install -a
