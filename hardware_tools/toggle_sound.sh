# !/bin/bash

# toggle mute on the default sink
user=$(id -nu $SUDO_UID)
sudo -user $user XDG_RUNTIME_DIR=/run/user/$SUDO_UID pactl set-sink-mute @DEFAULT_SINK@ toggle

# chnge led ligh on keybaord
/usr/src/hardware_tools/control_mute_led.sh
