#!/bin/bash
echo "Recording video"
sudo python ~/base/code/temp/Record.py --IP $IP --box $box --experiment $experiment --cage $cage --animal $animal --totaltime $totaltime --sex $sex --weight $weight --dob $dob --strain $strain --virus $virus --day $day --notes $notes --ziplistfile $ziplistfile --videodir $video_dir --logdir logdir
exit
exec $SHELL
