#!/bin/bash
#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
mkdir -p ~/test_video_archive/
dt=$(date '+%d_%m_%Y_%H_%M_%S');

echo "start up screen session"
for line in $Lines;
do
echo ${line[0]}
sshpass -p "estrin1" ssh -n -tt ${line[0]} 'screen -wipe && screen -dmS $dt && exit && exit; exec bash -l'
done

echo "Recording videos"
while IFS=, read IP box; do
echo "Recording video for box" $box
mkdir -p ~/test_video_archive/${box}/
sshpass -p "estrin1" ssh -n -tt $IP 'screen -S $dt -p 0 -X stuff "bash ~/base/code/temp/RUN.sh\n" && exit && exit;exec bash -l'
done < IPS.txt

#echo "Zipping files"
#while IFS=, read IP box; do
#echo $IP
#sshpass -p "estrin1" ssh -n -tt $IP 'sudo apt-get install sshpass && exit; exec bash -l'
#sshpass -p "estrin1" ssh -n -tt $IP 'sshpass -p "estrin1" rsync -var --progress ~/test_zip.zip pi@192.168.0.147:~/test_video_archive/${box}/ && exit; exec bash -l'
#done < IPS.txt

