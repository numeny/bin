#!/bin/bash
ANDROID_PATH=/home/bdg/ssd/android/AndroidSource
#DIR_PATH=/tmp/semob_symbol
#LIB_NAME=semob_android_wk-pdb-1.1.1-1.1.1.355-libsogou_content_shell_content_view.so-629FC2BBEEFF5C24B9C7017C2178E1C70-libsogou_content_shell_content_view.so.sym
DIR_PATH=/home/bdg/browser/chromium.56.0.2924.116.2/src
#DIR_PATH=/tmp/
LIB_NAME=out/Default/lib.unstripped/libchrome.cr.so
if [[ $# -ne 1 && $# -ne 0 && $# -ne 2 ]]
then
  echo "[usage] $0"
  exit 0
fi
#echo DIR_PATH=$DIR_PATH
#echo LIB_NAME=$LIB_NAME
#echo FUNC_ADDRESS=$FUNC_ADDRESS
if [[ $# -eq 1 || $# -eq 2 ]]
then
while read line
do
if [[ $# -eq 1 ]]
then
${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} `echo $line | awk '{print $1}' | sed -n '1p'`
else
${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} `echo $line | awk '{print $1}' | sed -n '1p'`
fi

done < $1
else
while [[ 1 ]]
do
read FUNC_ADDRESS
echo $FUNC_ADDRESS
echo ${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
done
fi
