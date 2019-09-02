#/bin/bash
if [[ $# > 1 ]]; then
echo "$0 [PROXY_PORT]"
exit 1
elif [[ $# -eq 1 ]]; then
PORT=$1
else
PORT=8999
fi

sudo mitmproxy -p $PORT
