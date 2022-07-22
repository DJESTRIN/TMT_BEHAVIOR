#!/bin/bash
echo "Collecting recording data via Rsync to server"
while IFS=, read IP box experiment cage animal totaltime sex weight dob strain virus day notes ziplistfile videodir logdir;
do
ssh -n -tt $IP "rsync -varz --stats /media/usb/base/videos/07_18_2022/ dje4001@scu-vis1.med.cornell.edu:/athena/listonlab/store/dje4001/rsync_data/BB0046_RECORDING_SYSTEM/ && exit; exec bash -l"
done < /home/pi/TMT_BEHAVIOR/schedule.txt

echo "Finished"

# rsync -varz --stats /media/usb/base/videos/07_18_2022/ dje4001@scu-vis1.med.cornell.edu:/athena/listonlab/store/dje4001/rsync_data/BB0046_RECORDING_SYSTEM/


