#!/bin/bash
ANDROID_PATH_1=/home/bdg/ssd/android/AndroidSource
export LIB_NAME=/home/bdg/ssd/chromium.android_webview/src/out/Release/lib.unstripped/libsogouwebview.so
cat $1 | grep "libsogouwebview.so" | awk '{print $7}' | ${ANDROID_PATH_1}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${LIB_NAME}
