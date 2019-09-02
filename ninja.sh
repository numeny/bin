#/bin/bash
ninja -C out/Release/ sogou_webview
if [[ $? -ne 0 ]];then
echo "xxxxxxxxxxxx buiding error xxxxxxxxxxxxxxxxxxxxx" 
exit -1
fi
touch.all
echo "============ buiding success =================="
