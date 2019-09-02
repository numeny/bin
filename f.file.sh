#!/bin/sh
if [ $# -eq 1 ];then
    SEARCH_PATH=.
    SEARCH_STR="$1"
elif [ $# -eq 2 ];then
    SEARCH_PATH=$1
    SEARCH_STR="$2"
else
    echo "[Usage] $0 [search_path] search_file"
    exit 0
fi

find $SEARCH_PATH -name "$SEARCH_STR" -type f | xargs ls -l
