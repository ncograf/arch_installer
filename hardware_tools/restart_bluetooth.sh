#! /bin/bash

systemctl start bluetooth
wait 1
bluetoothctl power on

