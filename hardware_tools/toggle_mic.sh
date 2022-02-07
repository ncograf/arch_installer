# !/bin/bash

# toggle mute on the default sink
sudo --user=nico XDG_RUNTIME_DIR=/run/user/1000 pactl set-source-mute @DEFAULT_SOURCE@ toggle

# chnge led ligh on keybaord
/home/nico/scripts/root_access/control_mic_led.sh

# change status bar 
kill -64 $(pidof dwmblocks)
