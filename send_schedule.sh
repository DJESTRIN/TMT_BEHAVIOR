#!/bin/bash/
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
for IP in $Lines;
do
sshpass -p "estrin1" ssh -t $IP 'sudo mkdir -p /media/usb/base/schedule/ && exit; exec bash -;'
/usr/bin/rsync -var --rsh="/usr/bin/sshpass -p estrin1 ssh -o StrictHostKeyChecking=no -l pi" ~/Desktop/schedule $IP:/media/usb/base/schedule
done
