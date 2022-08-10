#!/bin/bash
echo on

#Delete folders of interest
cd
sudo rm -rf temp 
sudo rm -rf base

#All targets in orchestra
cd ~/TMT_BEHAVIOR/
Lines=$(cat IPs.txt)

# SSH in and prepare the PIs
# Set up folders
base_dirs=( /media/usb/base/logs/ /media/usb/base/videos/ /home/pi/base/code/ )
code_dir=( /home/pi/base/code/temp/)

#Loop through IP addresses
for IP in $Lines;
do

	#build base directories
	for d in "${base_dirs[@]}";
	do
		echo $d
		sshpass -p "estrin1" ssh -t ${IP[0]} 'sudo mkdir -p '$d' && sudo rm -rf ~/temp && sudo rm -rf '${code_dir[0]}' && exit; exec bash -l'
	done

#git clone all nessesary code
sshpass -p "estrin1" ssh -t ${IP[0]} 'sudo killall screen $$ exit; exec bash -l'
sshpass -p "estrin1" ssh -tt ${IP[0]} 'git clone https://github.com/DJESTRIN/TMT_BEHAVIOR/ temp && sudo mv -v temp '${base_dirs[2]}' &&\
sudo rm -rf temp && exit; exec bash -l'
done

# Install all nessesary packages
for IP in $Lines;
do
sshpass -p "estrin1" ssh -tt ${IP[0]} 'cd ${code_dir[0]} && pip install -r requirements.txt && sudo apt-get install sshpass && sudo apt-get install screen && exit; exec bash -l'
done

echo "Finished preparing this raspberry pi"
echo off
