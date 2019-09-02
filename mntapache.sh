#/bin/bash
# mount 198 server to local
sudo mount -t smbfs -o codepage-cp936,iocharset=utf8 //192.168.16.198/apache /home/bdg/server/apache
sudo mount -t smbfs -o codepage-cp936,iocharset=utf8 //192.168.16.198/share /home/bdg/server/share
