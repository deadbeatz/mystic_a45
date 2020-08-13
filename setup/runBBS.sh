#!/bin/bash

if [ ! -f ".setup_complete" ]; then 
  # Modify rundoor.sh with user paths
  echo "Setting rundoor.sh paths for user:$USER"
	cp ./rundoor.sh /mystic
  sed -i 's/<USERHERE>/'"$(whoami)"'/g' /mystic/rundoor.sh
  chmod +x /mystic/rundoor.sh
  # Add node folders for Dosemu
	mkdir -p /home/$(whoami)/.dosemu/drive_c/nodes/temp1
  mkdir -p /home/$(whoami)/.dosemu/drive_c/nodes/temp2
  mkdir -p /home/$(whoami)/.dosemu/drive_c/nodes/temp3
  mkdir -p /home/$(whoami)/.dosemu/drive_c/nodes/temp4
  mkdir -p /home/$(whoami)/.dosemu/drive_c/nodes/temp5

  touch .setup_complete
fi

echo "Clearing .bsy files"
find . -name *.bsy -exec rm {} \;
echo "Starting MIS server"
cd /mystic
exec sudo /mystic/mis server
