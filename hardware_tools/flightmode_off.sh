# !/bin/bash

sudo /usr/src/hardware_tools/check_flightmode.sh

sudo rfkill unblock all

#if [ $(cat /etc/flightmode/wlan_mode) -eq 0 ]; then
#	nmcli r wifi off
#	echo "wifi off"
#else
#	nmcli r wifi on
#	echo "wifi on"
#fi
#
#if [ "$(cat /etc/flightmode/bluetooth_mode)" -eq 0 ]; then
#	while [ "$(bluetoothctl power off)" == "No default controller available" ]; do sleep 1; done
#	echo "bluetooth off"
#else
#	while [ "$(bluetoothctl power on)" == "No default controller available" ]; do sleep 1; done
#	echo "bluetooth on"
#fi

nmcli r wifi ou	
while [ "$(bluetoothctl power on)" == "No default controller available" ]; do sleep 1; done

echo 0 > /etc/flightmode/mode

# send siganl to dwm blocks
kill -54 $(pidof dwmblocks)
kill -55 $(pidof dwmblocks)
