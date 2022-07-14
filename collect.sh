#!/bin/bash
echo "Collecting recording data via Rsync to external hard drive"
while IFS=, read IP box experiment cage animal totaltime sex weight dob strain virus day notes ziplistfile videodir logdir;
do
mkdir -p /exfat/ESTRIN_RECORDING_SYSTEM/$box/
sshpass -p "estrin1" rsync -chavzP --no-o --no-g --no-perms --stats $IP:/media/usb/base/videos/ /exfat/ESTRIN_RECORDING_SYSTEM/$box/
done < /home/pi/TMT_BEHAVIOR/schedule.txt

echo "Finished"

