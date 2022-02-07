# !/bin/bash

# This script will read out the file ~/.config/flightmode/mode 
# and based on the result set the flightmode or turn if off

sudo /usr/src/hardware_tools/check_flightmode.sh

# check mode 
if [ $(cat /etc/flightmode/mode) -eq 0 ]; then
	sudo /usr/src/hardware_tools/flightmode_on.sh
else 
	sudo /usr/src/hardware_tools/flightmode_off.sh
fi
