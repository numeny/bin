#!/bin/bash
#adb shell ps  | grep "sogou.mobile.explorer"
adb shell /system/bin/gdbserver :5039 --attach `adb.ps.sh.webcore | awk '{print $2}' | sed -n '1p'`
