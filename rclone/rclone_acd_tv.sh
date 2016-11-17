#!/bin/bash

local_dir_tv=/mnt/MrU/Videos/Series
log=$HOME/Scripts/logs/log.rclone_tv
exclude=.DS_Store
remote_dir_tv=acd:Videos/Series

date >> $log
echo "TV Sync" >> $log

/usr/bin/rclone --stats 5m0s --exclude $exclude --log-file $log copy $local_dir_tv $remote_dir_tv

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log
