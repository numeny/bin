#!/bin/sh
export SUBCLASS=
export SEARCH_PATH=.
if [ $# -eq 1 ];then
    SUBCLASS=$1
elif [ $# -eq 2 ];then
    SEARCH_PATH=$1
    SUBCLASS=$2
else
    echo "[Usage] $0 [search path] sub-class-name"
    exit 1
fi
echo search path: [${SEARCH_PATH}] sub class: [${SUBCLASS}]
find ${SEARCH_PATH} -name "*.cpp" -o -name "*.h" | xargs grep "public.*\<${SUBCLASS}\>[\ |,|{]" --color=auto
find ${SEARCH_PATH} -name "*.cpp" -o -name "*.h" | xargs grep "private.*\<${SUBCLASS}\>[\ |,|{]" --color=auto
find ${SEARCH_PATH} -name "*.cpp" -o -name "*.h" | xargs grep "protected.*\<${SUBCLASS}\>[\ |,|{]" --color=auto
