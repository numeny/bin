#!/bin/bash
if [ $# -eq 1 ];then
kill_process_name=$1
else
kill_process_name="sogou.mobile.explorer:sandboxed_process0"
fi
pid_sogou_browser=`adb shell ps | grep $kill_process_name | awk '{print $2}'`
echo "adb shell su -c 'kill $pid_sogou_browser'"
adb shell "su -c 'kill $pid_sogou_browser'"
