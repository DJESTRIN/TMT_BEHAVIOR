#!/bin/bash
#All targets in orchestra
cd /home/pi/TMT_BEHAVIOR/
message="Trying to initiate screen session"
echo $message

while IFS=, read IP box experiment cage animal totaltime sex weight dob strain virus day notes ziplistfile videodir logdir;
do
sshpass -p "belfer10" ssh -n -tt $IP 'tag=$(date "+%Y%m%d%H%M%S") && screen -dmS $tag bash -c "echo $message; exec bash" && screen -r $tag -p 0 -X stuff "bash /home/pi/TMT_BEHAVIOR/Record_RUN.sh\n" && exit; exec bash -l'
done < /home/pi/TMT_BEHAVIOR/schedule.txt
