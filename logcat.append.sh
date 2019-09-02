#/bin/sh
echo "" >> $1
echo "" >> $1
echo "------------------------------------------" >> $1
echo "" >> $1
adb shell logcat -c
adb shell logcat | grep mmm >> $1
