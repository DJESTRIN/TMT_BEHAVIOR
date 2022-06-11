#!/bin/bash

#Loop through Pis, zip recent 

t_pwd="raspberry"
IPs=( pi@169.254.177.61 pi@192.168.0.246 pi@192.168.0.169 pi@192.168.0.227\
 pi@192.168.0.108 pi@192.168.0.103 pi192.168.0.249 pi@192.168.0.224 pi@192.168.0.172\
 pi@192.168.0.129 pi@192.168.0.185 pi@192.168.0.122 pi@192.168.0.191 pi@192.168.0.217 )

boxs=( 6 5 9 10 11 14 15 12 13 7 4 1 3 2 )

for IP in "${IPs[@]}"
do
sshpass -p $t_pwd ssh -t $IP 'ziplist = locate -i "ziplist.txt" && \
cd ~/base/videos/ && \
while IFS=, read video_filename; do
zip ${video_filename::-4} video_filename
sudo mv video_filename ~/base/video_archive/
done < $ziplist && \
rsync -var ~/base/videos/ David@XXX.XXX.X.XXX:/e/ && 
df -h &&\
exit; exec bash -l'
echo "Box number ${boxs[@]} is finished: check for errors"
done

echo "User must now manual rsync data to WCM server"
