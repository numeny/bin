#!/bin/bash
#ANDROID_PATH=`pwd`
ANDROID_PATH=/home/bdg/ssd/android/AndroidSource
#DIR_PATH=~/downloads
#LIB_NAME=sogouwebkit-dev-2014-05-14-13-52-58-libsogouwebcore-symbol.so
#DIR_PATH=${ANDROID_PATH}/out/target/product/generic/symbols/system/lib/
DIR_PATH=out/Release/lib
LIB_NAME=libsogou_content_shell_content_view.so
if [[ $# -ne 1 && $# -ne 0 && $# -ne 2 ]]
then
  echo "[usage] $0 [lib_name] [func_address]"
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
${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} `echo $line | awk '{print $4}' | sed -n '1p'`
else
${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} `echo $line | awk '{print $5}' | sed -n '1p'`
fi

done < $1
else
while [[ 1 ]]
do
read FUNC_ADDRESS
${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
done
fi
