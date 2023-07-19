#!/bin/bash/
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
for IP in $Lines;
do
sshpass -p "estrin1" ssh -t $IP 'sudo mkdir -p /media/usb/ && (sudo mount /dev/sdb1 /media/usb -o uid=pi,gid=pi || sudo mount /dev/sda1 /media/usb -o uid=pi,gid=pi) && exit; exec bash -;'
done
