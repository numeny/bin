#!/bin/sh
if [ $# -ne 1 ];then
    echo "[Usage] $0 <file>"
    exit 0
fi

touch -d "2099-01-01 12:00" $1
ls -l $1
