# !/bin/bash

# toggle mute on the default sink
sudo --user=nico XDG_RUNTIME_DIR=/run/user/1000 pactl set-sink-mute @DEFAULT_SINK@ toggle

# chnge led ligh on keybaord
/home/nico/scripts/root_access/control_mute_led.sh

# change status bar 
kill -44 $(pidof dwmblocks)
