#!/bin/bash
#adb shell ps  | grep "sogou.mobile.explorer"
if [[ $# -ne 1 ]]
then
echo "[Usage] $(basename $0) <line_number_of_SogouExplorer>"
fi
adb shell /system/bin/gdbserver :5040 --attach $1
