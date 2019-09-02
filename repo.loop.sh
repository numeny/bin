#!/bin/bash
MAX=1000
ls aaaaaaaaaaaaaaaa
for (( i = 0; i < MAX ; i ++ ))
do
if [ $? -ne 0 ];then
echo "syncing ... $i" >> /tmp/log.repo
repo sync -j8 >> /tmp/log.repo
fi
done
