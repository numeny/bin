#!/bin/bash
CURR_DIR=`pwd`
DIR_PATH=$CURR_DIR/out/Release/lib.unstripped
#DIR_PATH=/tmp/
LIB_NAME=libsogouwebview.so

#ADDR2LINE=third_party/android_ndk/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-addr2line
ADDR2LINE=third_party/android_tools/ndk/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-addr2line
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
${CURR_DIR}/${ADDR2LINE} -C -f -e ${DIR_PATH}/${LIB_NAME} `echo $line | awk '{print $1}' | sed -n '1p'`
else
${CURR_DIR}/${ADDR2LINE} -C -f -e ${DIR_PATH}/${LIB_NAME} `echo $line | awk '{print $1}' | sed -n '1p'`
fi

done < $1
else
while [[ 1 ]]
do
read FUNC_ADDRESS
echo $FUNC_ADDRESS
echo ${CURR_DIR}/${ADDR2LINE} -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
${CURR_DIR}/${ADDR2LINE} -C -f -e ${DIR_PATH}/${LIB_NAME} ${FUNC_ADDRESS}
done
fi
