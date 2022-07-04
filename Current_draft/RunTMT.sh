#!/bin/bash
echo on

# Target IP addresses in orchestra
t_pwd="estrin1"
base_dirs=( /home/pi/base/code/temp/ )
cd ~/

while IFS=, read IP box cage totaltime animal sex weight dob strain virus day notes; do
#SSH in, start screen, run TMT trial
sshpass -p $t_pwd ssh -tt $IP 'screen -S TMT && screen -d -m -t TMT bash -c "cd '${base_dirs[0]}'; python TMT.py --ip $IP --box $box --cage $cage --totaltime $totaltime --animal $animal --sex $sex --weight $weight --dob $dob --strain $strain --virus $virus --day $day --notes $notes" && screen -D && exit; exec bash -l' \
|| echo "TMT code was not executed on $IP"
done < schedule.txt

echo off
