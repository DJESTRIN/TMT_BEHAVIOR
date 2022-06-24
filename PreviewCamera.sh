#!/bin/bash
echo on
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

for IP in $Lines:
do
sshpass -p "" ssh -tt ${IP[0]} 'screen -dm bash -c "python preview.py" && exit; exec bash -l'
done

echo "Finished previewing cameras"
