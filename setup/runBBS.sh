#!/bin/bash

if [ ! -f ".setup_complete" ]; then 
  # Modify rundoor.sh with user paths
  echo "Setting rundoor.sh paths for user:$USER"
	cp ./rundoor.sh /mystic
  sed -i 's/<USERHERE>/'"$(whoami)"'/g' /mystic/rundoor.sh
  chmod +x /mystic/rundoor.sh
  touch .setup_complete
fi

echo "Clearing .bsy files"
find . -name *.bsy -exec rm {} \;
echo "Starting MIS server"
cd /mystic
exec sudo /mystic/mis server
