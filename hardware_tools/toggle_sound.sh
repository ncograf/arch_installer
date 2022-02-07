# !/bin/bash

# toggle mute on the default sink
sudo -user $SUDO_UID XDG_RUNTIME_DIR=/run/user/$SUDO_UID pactl set-sink-mute @DEFAULT_SINK@ toggle

# chnge led ligh on keybaord
/usr/src/hardware_tools/control_mute_led.sh

# change status bar 
kill -44 $(pidof dwmblocks)
