#!/bin/bash
#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

echo "Please remember to watch the code to see if all boxes are tested"
sleep 3



#Set up at home directory for data storage
while IFS=, read IP box;do
mkdir -p ~/video_archive/${box}/
done < IPS.txt

# Kill all screens
while IFS=, read IP box;do
echo "SSH into " IP " and kill screen session for box " box
sshpass -p "estrin1" ssh -tt $IP 'killall screen && exit; exec bash -l'
done < IPS.txt

# Initalize all screens
while IFS=, read IP box;do
echo "SSH into " IP " and start screen session for box " box
sshpass -p "estrin1" ssh -tt $IP 'screen -dmS testscreen && exit; exec bash -l'
done < IPS.txt

# Run a preview
while IFS=, read IP box;do
echo "SSH into " IP " and run preview for box " box
sshpass -p "estrin1" ssh -tt $IP 'screen -S testscreen -p 0 -X stuff "python ~/base/code/temp/preview.py" && exit; exec bash -l'
done < IPS.txt

# Rsync zipped data to conductor pi
while IFS=, read IP box;do
echo "SSH into " IP " and rsync data for box " box
sshpass -p "estrin1" ssh -tt $IP 'screen -S testscreen -p 0 -X stuff "rsync -var ~/test_zip.zip pi@192.168.0.147:~/video_archive/$box/" && exit; exec bash -l'
done < IPS.txt

