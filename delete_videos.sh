#!/bin/bash
#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

#Loop through IP addresses
for IP in $Lines;
do
#Delete all videos on the pi
sshpass -p "estrin1" ssh -tt ${IP[0]} 'sudo killall screen && sudo rm -rf /home/pi/base/videos/* && exit; exec bash -l'
done


