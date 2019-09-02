#!/bin/bash
export CHOMIUM_SOGOU_PATH=/home/bdg/ssd/chromium_68.0.3440.106/src/
export SHELL_DEBUG_PATH=/home/bdg/ssd/shell/trunk_chrome_68/
cp $CHOMIUM_SOGOU_PATH/sogou_webview/java/src/com/sogou/chromium/player/* $SHELL_DEBUG_PATH/sogouwebviewsrc/originsrc/com/sogou/chromium/player/ -rf
