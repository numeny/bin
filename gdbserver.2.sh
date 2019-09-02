#!/bin/bash
#adb shell ps  | grep "sogou.mobile.explorer"
if [[ $# -ne 1 ]]
then
echo "[Usage] $(basename $0) <line_number_of_SogouExplorer>"
fi
if [[ $1 -eq "1" ]]
then
pid_sogou_browser=`adb.ps.sh | awk '{print $2}' | sed -n '1p'`
elif [[ $1 -eq "2" ]]
then
pid_sogou_browser=`adb.ps.sh | awk '{print $2}' | sed -n '2p'`
elif [[ $1 -eq "3" ]]
then
pid_sogou_browser=`adb.ps.sh | awk '{print $2}' | sed -n '3p'`
elif [[ $1 -eq "4" ]]
then
pid_sogou_browser=`adb.ps.sh | awk '{print $2}' | sed -n '4p'`
fi
adb shell "su -c '/data/bdg/gdbserver :5039 --attach $pid_sogou_browser'"
