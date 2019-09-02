#!/bin/bash
adb forward tcp:5040 tcp:5040
/home/bdg/chromium/src/third_party/android_tools/ndk/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gdb --command=~/bin/gdbinit.sogou.chrome.68 ~/bin/app_process
