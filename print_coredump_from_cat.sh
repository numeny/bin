#!/bin/bash
ANDROID_PATH_1=`pwd`
export DIR_PATH=${ANDROID_PATH_1}/out/target/product/generic/symbols/system/lib/
#export DIR_PATH=/var/www/new-webcore/white-blank-new-webcore/9-6/
export LIB_NAME=libsogouwebcore.so
#echo DIR_PATH=$DIR_PATH
#echo LIB_NAME=$LIB_NAME
#echo FUNC_ADDRESS=$FUNC_ADDRESS
#${ANDROID_PATH}/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
cat $1 | grep "\ pc\ " | grep "libsogouwebcore" | awk '{print $4}' | prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-addr2line -C -f -e ${DIR_PATH}/${LIB_NAME}
