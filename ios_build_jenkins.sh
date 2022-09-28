#!/bin/bash
#
# 通过shell脚本来启动构建
##
# 参数说明：
# $1:  打包类型debug|release
# $2:  打包版本号
buildType=$1
versionName=$2


flutter doctor
flutter packages pub get
pod repo update
find . -name "Podfile" -execdir pod install \;
flutter build ipa --"${buildType}" --build-name="${versionName}" --export-method ad-hoc



