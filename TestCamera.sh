#!/bin/bash
echo on

#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

while IFS=, read  IP box;
do
#ssh in and run test.py
echo IP box
sshpass -p "estrin1" ssh -tt ${IP} 'python test.py && rsync -var ~/test_zip.zip pi@192.168.0.147:~/video_archive/'${box}'/ && exit; exec bash -l'
done < IPS.txt

