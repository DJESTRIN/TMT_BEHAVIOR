#!/bin/bash
echo on

#Delete folders of interest
cd
sudo rm -rf temp 
sudo rm -rf base

#All targets in orchestra
IPs=( pi@192.168.0.119 )
target_password="pi"

# SSH in and prepare the PIs
# Set up folders
base_dirs=( /home/pi/base/logs/ /home/pi/base/videos/ /home/pi/base/data/ )
code_dir=( /home/pi/base/code/temp/ )

#Loop through IP addresses
for IP in "${IPs[@]}"
do

	#build base directories
	for d in "${base_dirs[@]}"
	do
		echo $d
		sshpass -p $target_password ssh -t $IP\
		'sudo mkdir -p '$d' && exit; \
		exec bash -l' || echo "Error building the base directory"
	done

#git clone all nessesary code
sshpass -p $target_password ssh -t $IP 'git clone\
https://github.com/DJESTRIN/TMT_BEHAVIORAL_TRACKING temp && sudo mv -v temp '${base_dirs[1]}' &&\
sudo rm -rf temp\
&& exit; exec bash -l' || echo "Error with $IP"
done

# Install all nessesary packages
for IP in "${IPs[@]}"
do 
sshpass -p $target_password ssh -t $IP 'cd '${code_dir[0]}' && pip install -r requirements.txt && exit\
exec bash -l' || echo "Error with installing requirements"
done 

echo "Finished preparing this raspberry pi"
echo off 
