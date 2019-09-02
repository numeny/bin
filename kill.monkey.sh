#!/bin/bash
adb shell kill -9 `adb shell ps | grep  "com.android.commands.monkey" | awk '{print $2}' | sed -n '1p'`
