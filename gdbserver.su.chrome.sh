#!/bin/bash
#adb shell ps  | grep "sogou.mobile.explorer"
if [[ $# -ne 1 ]]
then
echo "[Usage] $(basename $0) <pid_sogou_browser>"
exit 0
fi
pid_sogou_browser=$1
echo adb shell "su -c '/data/bdg/gdbserver :5040 --attach $pid_sogou_browser'"
adb shell "su -c '/data/bdg/gdbserver :5040 --attach $pid_sogou_browser'"
