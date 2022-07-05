#!/bin/bash
#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
mkdir -p ~/test_video_archive/

message="start up screen session"
echo $message
for line in $Lines;
do
echo ${line[0]}
sshpass -p "estrin1" ssh -n -tt ${line[0]} 'tag=$(date "+%Y%m%d%H%M%S") && screen -dmS $tag bash -c "echo $message; exec bash" && screen -r $tag -p 0 -X stuff "bash ~/base/code/temp/RUN.sh\n" && exit; exec bash -l'
done

#echo "Recording videos"
#while IFS=, read IP box; do
#echo "Recording video for box" $box
#mkdir -p ~/test_video_archive/${box}/
#sshpass -p "estrin1" ssh -n -tt $IP 'screen -RR -p 0 -X stuff "bash ~/base/code/temp/RUN.sh\n" && exit;exec bash -l'
#done < IPS.txt

#echo "Zipping files"
#while IFS=, read IP box; do
#echo $IP
#sshpass -p "estrin1" ssh -n -tt $IP 'sudo apt-get install sshpass && exit; exec bash -l'
#sshpass -p "estrin1" ssh -n -tt $IP 'sshpass -p "estrin1" rsync -var --progress ~/test_zip.zip pi@192.168.0.147:~/test_video_archive/${box}/ && exit; exec bash -l'
#done < IPS.txt

