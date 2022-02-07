# !/bin/bash

# set check the current state ( 1 -> Mute, 0 -> not muted )
mute_state=$(sudo -u nico XDG_RUNTIME_DIR=/run/user/1000 pactl get-sink-mute @DEFAULT_SINK@ | grep -e 'Mute: yes' -e 'Mute: ja' | wc -l)

echo $mute_state > /sys/class/leds/platform\:\:mute/brightness
