#!/bin/bash
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
for line in $Lines;
do
echo ${line[0]}
sshpass -p "estrin1" ssh -tt ${line[0]} 'screen -dmS testscreen && screen -S testscreen -p 0 -X stuff 'bash ./RUN.sh\n' && exit; exec bash -l'
done



