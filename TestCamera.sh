#!/bin/bash
#All targets in orchestra
cd ~/TMT_BEHAVIOR/
while IFS=, read IP box; do
echo "$IP"
echo This is box "$box"
sshpass -p "estrin1" ssh -n -tt $IP 'python ~/base/code/temp/preview.py && rsync -var ~/test_zip.zip pi@192.168.0.147:~/video_archive/$box/ && exit; exec bash -l'
done < IPS.txt

