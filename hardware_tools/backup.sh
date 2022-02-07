#!/bin/bash


# create mount directory
dev=/dev/sda1
mount /dev/sda1 /mnt

if [ ! [$? == 0] ] ; then

  dev=/dev/sdb1
  mount /dev/sdb1 /mnt

fi

if [ ! [$? == 0] ] ; then

  echo "device not plugged in"
  return 1

fi

# create backupfolder
dire=/mnt/$(echo $HOSTNAME)_$(date +"%Y_%m_%d_%H_%M")
mkdir $dire

# start backup
rsync -aEDSz --progress --stats --exclude-from '/home/nico/scripts/root_access/rsync_exclude' /home/nico --exclude 'llvm-project' /usr/src $dire

