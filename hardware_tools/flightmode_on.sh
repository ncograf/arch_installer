# !/bin/bash

sudo /usr/src/hardware_tools/check_flightmode.sh

#if [  "$(bluetoothctl show | grep -e 'Powered: yes' | wc -l)" -eq 0 ] && [ "$(nmcli d status | grep -e ' wifi '*' verbunden ' | wc -l)" -eq 0 ]; then
#	# if both ar off it makes no sence to leave them off
#	echo 1 > /etc/flightmode/bluetooth_mode
#	echo 1 > /etc/flightmode/wlan_mode
#else
#	if [ "$(bluetoothctl show | grep -e 'Powered: yes' | wc -l)" -eq 0 ]; then
#	       	echo 0 > /etc/flightmode/bluetooth_mode
#	       	echo "set bluetooth off"
#        else
#		echo 1 > /etc/flightmode/bluetooth_mode
#	fi
#
#	if [ "$(nmcli d status | grep -e ' wifi '*' verbunden ' | wc -l)" -eq 0 ]; then
#		echo 0 > /etc/flightmode/wlan_mode
#		echo "set wlan off"
#	else
#		echo 1 > /etc/flightmode/wlan_mode
#	fi
#fi

sudo rfkill block all

echo 1 > /etc/flightmode/mode
