#!/bin/bash
adb shell logcat -c
adb shell monkey -p sogou.mobile.explorer --monitor-native-crashes --pct-touch 80 --pct-motion 15 --pct-nav 5  -v --throttle 1000 320000 >> /home/bdg/tmp/monkey.log.11
adb shell logcat >> /home/bdg/tmp/monkey.log.logcat.22
