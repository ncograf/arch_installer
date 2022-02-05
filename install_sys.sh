#!/bin/bash

# Never run pacman -Sy on your system!
pacman -Sy dialog

timedatectl set-ntp true

dialog --defaultno --title "WARNING" --yesno \
    "This script will DESTROY EVERYTHING on one of the hard disks. \n\n\
    Choose yes to continue?" 15 60 || exit

# the output will go the the error since the dialog function usess the standard output to draw things on the screen 
dialog --no-cancel --inputbox "Computer name" \
    10 60 2> comp 

# Verify boot (UEFI or BIOS)
uefi=0
ls /sys/firmware/efi/efivars 2> /dev/null && uefi=1

devices_list=($(lsblk -d | awk '{print "/dev/" $1 " " $4 " on "}' \
    | grep -E 'sd|hd|vd|nvme|mmcblk'))

dialog --title "Choose hard drive" --no-cancel --radiolist \
    "Select with SPACE, valid with ENTER. \n\n\
        WARNING: Everything will be DESTROYED on the hard disk!" \
        15 60 4 "${devices_list[@]}" 2> hd

hd=$(cat hd) && rm hd

default_swap="32"
dialog --no-cancel --inputbox  \
    "The boot partition will be 512M \n\
    The root partition will be the remaining of the hard disk \n\
    The swap partition will be the input of this dialog. \n\n \
    Enter the partition size (in Gb) for the swap. \n\n\
    If you don't enter anything, it will default to ${default_swap}G. \n"\
        20 60 2> swap_size

size=$(cat swap_size) && rm swap_size

[[ $size =~ ^[0-9]+$ ]] || size=$default_swap

dialog --no-cancel \
    --title "!!! DELETE EVERYTHING !!!" \
    --menu "Choose the way to wipe the hard disk ($hd)" \
    15 60 4 \
    1 "Use dd (wipe all disk)" \
    2 "Use schred (slow & secure)" \
    3 "No need - my hard disk is empty" 2> eraser

hderaser=$(cat eraser); rm eraser

function eraseDisk() {
    case $1 in 
        1) dd if=/dev/zero of="$hd" status=progress 2>&1 \
            | dialog \
            --title "Formatting $hd..." \
            --progressbox --stdout 20 60;;
        2)  shred -v "$hd" \
            | dialog \
            --title "Formatting $hd..." \
            --progressbox --stdout 20 60;;
        3) ;;
    esac
}

eraseDisk "$hderaser"

boot_partition_type=1
[[ "$uefi" == 0 ]] && boot_partition_type=4

#g - create non empty GPT partition table
#n - create new partition 
#p - primary partition 
#e - extended partition
#w - write the table to disk and exit
#t - change the partition type

#######################
# !!!! IMPORTANT !!!!!#
#######################
# the empty line after the n are necessary !!
# after n it first asks the partition number which we default with a \n
# then it asks the first sector which we again default with \n
# then the last sector has to be +512M because the boot partition is only that large
# in the last partition we select the default which is just the rest of the partition hence 3 \n

partprobe "$hd"
fdisk "$hd" << EOF
g
n


+512M
t
$boot_partition_type
n


+${size}G
n



w
EOF

partprobe "$hd"

# end of the necessary empty lines

# make partitions
mkswap "${hd}2"
swapon "${hd}2"
mkfs.ext4 "${hd}3"
mount "${hd}3" /mnt

if [ "$uefi" = 1 ]; then
    mkfs.fat -F32 "${hd}1"
    mkdir -p /mnt/boot/efi
    mount "${hd}1" /mnt/boot/efi
fi

pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

# Persist important values for the next script
echo "$uefi" > /mnt/var_uefi
echo "$hd" > /mnt/var_hd
mv comp /mnt/comp

curl https://raw.githubusercontent.com/ncograf/arch_installer/master/install_chroot.sh > /mnt/install_chroot.sh

arch-chroot /mnt bash install_chroot.sh

rm /mnt/var_uefi
rm /mnt/var_hd
rm /mnt/install_chroot.sh

dialog --title "reboot?" --yesno \
    "The install is done!\n\n\
    reboot computer?" 20 60

response=$?
case $response in
    0) reboot;;
    1) clear;;
esac

