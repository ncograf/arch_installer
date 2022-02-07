# !/bin/bash

# note that this file can only be changed with root priviledge
# this is because it is set executable as root without root priviledge 
# which is a security bug if it can be changed by a normal user

# get max brightness
max=$(</sys/class/backlight/amdgpu_bl0/max_brightness)

# get the current brightness
current=$(</sys/class/backlight/amdgpu_bl0/brightness)

# set step percentage 
step=$(echo "scale=0; ( $max * $2 * 0.01 ) / 1 " | bc -l)

# check if the parameter are given
if [ -z "$1" ] || [ -z "$2" ]; then
	exit 1
fi

# check the direction
if [ $1 = up ]; then
	next=$(($current + $step))
elif [ $1 = down ]; then
	next=$(($current - $step))
fi

# limit form below
if [ $next -lt 0 ]; then next=0; fi

# limit form above
if [ $next -gt $max ]; then next=$max; fi

# write out the file
echo $next >> /sys/class/backlight/amdgpu_bl0/brightness

exit 0
