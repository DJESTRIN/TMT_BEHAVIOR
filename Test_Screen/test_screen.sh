
#!/bin/bash
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

for line in $Lines;
do
echo "Killing all screen in "${line[0]}
sshpass -p "estrin1" ssh -tt ${line[0]} 'killall screen && exit; exec bash -l'
done

for line in $Lines;
do
echo "Attempting to initalize screen in " ${line[0]}
sshpass -p "estrin1" ssh -tt ${line[0]} 'screen -dmS testscreen && exit; exec bash -l'
done

for line in $Lines;
do
echo "Attempting to reatacth and run scipt on screen in " ${line[0]}
sshpass -p "estrin1" ssh -tt ${line[0]} 'screen -S testscreen -p 0 -X stuff "bash ~/base/code/temp/RUN.sh\n" && exit; exec bash -l'
done



