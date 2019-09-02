#!/bin/bash
if [[ $# -ne 1 ]];then
echo "[Usage] $0 file-name"
fi

while read line
do
echo $line | awk '{print $4}' | sed -n '1p'
done < $1
