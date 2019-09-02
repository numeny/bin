#!/bin/bash
ANDROID_PATH=/home/bdg/ssd/android/AndroidSource
DIR_PATH=${ANDROID_PATH}/out/target/product/generic/symbols/system/lib/
LIB_NAME=libsogouwebcore.so
#echo DIR_PATH=$DIR_PATH
#echo LIB_NAME=$LIB_NAME
#echo FUNC_ADDRESS=$FUNC_ADDRESS
#${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
logcat | grep "\ pc\ " | awk '{print $5}' | prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME}
