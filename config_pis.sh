#!/bin/bash
echo on

# Go to code repo on main raspberry pi
cd /home/pi/TMT_BEHAVIOR/
git checkout NAS

# SSH in and prepare the PIs
# Set up mounted drive folder
data_drop=( /home/pi/NAS/ )

#Loop through IP addresses
while IFS=, read IP box;
do
	#Create mounted directory variable
	mounted_directory=/share/data/bb0046/box$box
	
	# Generate path for network drive
	sshpass -p "estrin1" ssh -t ${IP[0]} 'sudo mkdir -p '$data_drop' && sudo chmod -R 777 '$data_drop' && sudo chown pi:pi '$data_drop' && exit; exec bash -l'
	
	#install packages
	sshpass -p "estrin1" ssh -t ${IP[0]} '(sudo apt-get install sshpass nfs-common portmap screen || echo 'instalation did not work') && exit; exec bash -l'
	
	#Kill all screen sessions
	sshpass -p "estrin1" ssh -t ${IP[0]} '(sudo killall screen || echo nvm) && exit; exec bash -l'
	
	#Mount the NAS virtual directory
	sshpass -p "estrin1" ssh -t ${IP[0]} 'sudo service rpcbind start && sudo update-rc.d rpcbind enable && showmount -e 192.168.6.1 && sudo mount -t nfs 
192.168.6.1:$mounted_directory '$d' && exit; exec bash -l'

	#git clone all nessesary code
	sshpass -p "estrin1" ssh -tt ${IP[0]} 'cd /home/pi/ && git clone https://github.com/DJESTRIN/TMT_BEHAVIOR/' && exit; exec bash -l'

done < /home/pi/TMT_BEHAVIOR/IPs.txt

echo "Finished preparing this raspberry pi"
echo off
