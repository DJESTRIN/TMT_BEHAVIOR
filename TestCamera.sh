#!/bin/bash
#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)
sudo rm -rf ~/test_video_archive/
mkdir -p ~/test_video_archive/

message="start up screen session"
echo $message
for line in $Lines;
do
echo ${line[0]}
sshpass -p "estrin1" ssh -n -tt ${line[0]} 'tag=$(date "+%Y%m%d%H%M%S") && screen -dmS $tag bash -c "echo $message; exec bash" && screen -r $tag -p 0 -X stuff "bash ~/base/code/temp/RUN.sh\n" && exit; exec bash -l'
done

sleep 60

echo "Zipping videos"
while IFS=, read IP box; do
echo "Zipping videos for box" $box
mkdir -p ~/test_video_archive/${box}/
sshpass -p "estrin1" rsync -chavzP --stats $IP:~/base/videos/test_zip.zip ~/test_video_archive/$box/ || echo "Error occured for " $box
done < IPS.txt

while IFS=, read IP box; do
cd ~/test_video_archive/${box}/
unzip test_zip.zip
echo "box number" $box "has had data unzipped!"
done < IPS.txt
