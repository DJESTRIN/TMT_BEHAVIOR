#!/bin/bash
echo "Recording video"
while IFS=, read IP box experiment cage animal totaltime sex weight dob strain virus day notes ziplistfile videodir logdir;
do
IPaddress=$(hostname -I)
IPaddress="$IPaddress"
IPaddress="pi@"$IPaddress

echo $IPaddress
echo $IP

if [ $IP == $IPaddress ];
	then
		todaydir="$(date +"%m_%d_%Y")"
		videodir="$videodir$todaydir/"
		logdir="$logdir$todaydir/"
		mkdir -p $videodir
		mkdir -p $logdir
		echo "IP addresses MATCH!"
		sudo python /home/pi/base/code/temp/Record.py --ip $IP --box $box --experiment $experiment --cage $cage --animal $animal --totaltime $totaltime --sex $sex --weight $weight --dob $dob --strain $strain --virus $virus --day $day --notes $notes --ziplistfile $ziplistfile --videodir $videodir --logdir $logdir
		break
else
	echo "Addresses do not match"
fi
done < /home/pi/base/code/temp/schedule.txt

exit
exec $SHELL
