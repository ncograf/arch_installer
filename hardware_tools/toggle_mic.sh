# !/bin/bash

# toggle mute on the default sink
user=$(id -nu $SUDO_UID)
sudo -u $user XDG_RUNTIME_DIR=/run/user/$SUDO_UID pactl set-source-mute @DEFAULT_SOURCE@ toggle

# chnge led ligh on keybaord
/usr/src/hardware_tools/control_mic_led.sh
