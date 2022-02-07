# !/bin/bash

# This script will read out the file ~/.config/flightmode/mode 
# and based on the result set the flightmode or turn if off

sudo /home/nico/scripts/root_access/check_flightmode.sh

# check mode 
if [ $(cat /etc/flightmode/mode) -eq 0 ]; then
	sudo /home/nico/scripts/root_access/flightmode_on.sh
else 
	sudo /home/nico/scripts/root_access/flightmode_off.sh
fi
