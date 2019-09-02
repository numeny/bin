#!/bin/bash

WORK_PATH=/tmp
ZIP_FILE_LIST_NAME=crash_file.list
SYMBOL_SO_PATH=/tmp/a/sogouwebkit-vipper-4.3-2014-08-22-17-56-38-libsogouwebcore-symbol.so
SYMBOL_PARSED_PATH=/tmp/a/aaa/symbols/libsogouwebcore.so/90B3EC4D5196BFA1ED5070DCC61618BF0/sogouwebkit-vipper-4.3-2014-08-22-17-56-38-libsogouwebcore-symbol.so.sym
ZIP_FILE=${WORK_PATH}/${ZIP_FILE_LIST_NAME}
PARSED_DUMP_FILE_LIST=parsed_dump_file.list

cd $WORK_PATH
find $WORK_PATH -name "seandroid*.zip" > ${ZIP_FILE}
while read line
do
unzip $line
done < ${ZIP_FILE}

#parse so symbol
#create_dump_syms ~/bin/ ${SYMBOL_SO_PATH} ${WORK_PATH}/symbol/



cd $WORK_PATH
find $WORK_PATH -name "*.dmp" > ${DUMP_FILE_LIST}
while read line
do
minidump_stackwalk $line ${SYMBOL_PARSED_PATH} > $WORK_PATH/$line.log
done < ${DUMP_FILE_LIST}

cd $WORK_PATH
find $WORK_PATH -name "*.dmp.log" > ${WORK_PATH}/${PARSED_DUMP_FILE_LIST}
while read line
do

done < ${DUMP_FILE_LIST}
