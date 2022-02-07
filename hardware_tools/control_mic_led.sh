# !/bin/bash

# set check the current state ( 1 -> Mute, 0 -> not muted )
user=$(id -nu $SUDO_UID)
mute_state=$(sudo -u $user XDG_RUNTIME_DIR=/run/user/$SUDO_UID pactl get-source-mute @DEFAULT_SOURCE@ | grep -e 'Mute: yes' -e 'Mute: ja' | wc -l)

echo $mute_state > /sys/class/leds/platform\:\:micmute/brightness
