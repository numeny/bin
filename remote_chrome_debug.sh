#!/bin/bash
#Description
#     Script to start chrome remote debug on android.
#Owner: qiyanpeng@sogou-inc.com
#Date:  2013/10/29
#Version:  0.1

adb forward tcp:9222 localabstract:chrome_devtools_remote
chromium-browser --remote-debugging-port=9222 --remote-debugging-port=9898 --remote-debugging-frontend="http://localhost:9898" --app="http://localhost:9222"
echo "port 9222 is listening.\n"
