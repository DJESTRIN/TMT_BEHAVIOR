#!/bin/bash
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
for line in $Lines;
do
echo ${line[0]}
sshpass -p "raspberry" ssh -tt ${line[0]} 'echo "Success" && exit; exec bash -l'
done
