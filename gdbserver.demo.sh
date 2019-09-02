#!/bin/bash
#adb shell ps  | grep "sogou.mobile.explorer"
adb shell /system/bin/gdbserver :5039 --attach `adb shell ps | grep "explorer.demo" | awk '{print $2}'`
