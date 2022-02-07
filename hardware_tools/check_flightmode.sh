# !/bin/bash

# default values
default_wlan_on=1
default_bluetooth_on=1
default_flightmode_on=0

# generate direcotry if not existant
mkdir /etc/flightmode 2> /dev/null
mkdir /etc/flightmode 2> /dev/null

# if it did not exist create necessary files and assign defuatl values
if [ $? -eq 0 ]; then
	touch /etc/flightmode/wlan_mode
	echo $default_wlan_on > /etc/flightmode/wlan_mode
	touch /etc/flightmode/bluetooth_mode
	echo $default_bluetooth_on > /etc/flightmode/bluetooth_mode
	touch /etc/flightmode/mode
	echo $default_flightmode_on > /etc/flightmode/mode
	echo "set default values"
fi


exit 0
