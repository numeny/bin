#!/bin/bash
if [[ $# -eq 0 ]];then
build/android/adb_gdb_content_shell --output-directory=out/Debug/ 
elif [[ $# -eq 1 ]];then
build/android/adb_gdb_content_shell --output-directory=out/Debug/ --sandboxed=$1
else
echo "$0 [sandboxed-num]"
fi
