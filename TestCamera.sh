#!/bin/bash
echo on

#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

for IP in $Lines;
do
#ssh in and run test.py
sshpass -p "raspberry" ssh -tt ${IP[0]} 'python test.py && exit; exec bash -l' ||\
 sshpass -p "pi" ssh -tt ${IP[0]} 'python test.py && exit; exec bash -l'

done

