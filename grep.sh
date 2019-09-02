#!/bin/sh
if [ $# -eq 1 ];then
    SEARCH_PATH=.
    SEARCH_STR="$1"
elif [ $# -eq 2 ];then
    SEARCH_PATH=$1
    SEARCH_STR="$2"
else
    echo "[Usage] $0 [search_path] search_string"
    exit 0
fi

echo "$0 $SEARCH_PATH $SEARCH_STR"

find $SEARCH_PATH ! -name "tags" -a ! -name "cscope*" -a ! -name "filenametags" | xargs grep $SEARCH_STR
