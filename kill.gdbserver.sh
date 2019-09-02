#!/bin/bash
#adb shell ps  | grep "sogou.mobile.explorer"
if [[ $# -ne 0 ]]
then
echo "[Usage] $(basename $0)"
exit
fi
pid_gdbserver=`adb shell ps | grep gdbserver | awk '{print $2}' | sed -n '1p'`
echo "pid_gdbserver: $pid_gdbserver"
adb shell "su -c 'kill ${pid_gdbserver}'"
