# !/bin/bash

# set check the current state ( 1 -> Mute, 0 -> not muted )
mute_state=$(sudo -u nico XDG_RUNTIME_DIR=/run/user/1000 pactl get-source-mute @DEFAULT_SOURCE@ | grep -e 'Mute: yes' -e 'Mute: ja' | wc -l)

echo $mute_state > /sys/class/leds/platform\:\:micmute/brightness
