#!/bin/bash

IPs=( pi@169.254.177.61 pi@192.168.0.246 pi@192.168.0.169 pi@192.168.0.227\
 pi@192.168.0.108 pi@192.168.0.103 pi192.168.0.249 pi@192.168.0.224 pi@192.168.0.172\
 pi@192.168.0.129 pi@192.168.0.185 pi@192.168.0.122 pi@192.168.0.191 pi@192.168.0.217 )

t_pwd="raspberry"

boxs=( 6 5 9 10 11 14 15 12 13 7 4 1 3 2 )

for IP in "${IPs[@]}"
do
sshpass -p $t_pwd ssh -t $IP 'echo "Success" && exit; exec bash -l' && echo "${boxs[@]}"
done
