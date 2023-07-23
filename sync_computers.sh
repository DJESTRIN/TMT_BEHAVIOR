#!/bin/bash

while IFS=, read IP box;
do

echo $IP
rsync -var /home/pi/TMT_BEHAVIOR/ $IP:/home/pi/TMT_BEHAVIOR/ 

done < /home/pi/TMT_BEHAVIOR/IPSaddresses.txt

exit
exec $SHELL
