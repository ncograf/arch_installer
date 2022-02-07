# !/bin/bash

# unblock all devices
sudo rfkill unblock all

# start bluetooth
bluetoothctl power on

# mark in flightmode control
echo 1 >/etc/flightmode/bluetooth_mode

# start wifi
nmcli radio wifi on

# mark in flightmode control
echo 1 > /etc/flightmode/wlan_mode

