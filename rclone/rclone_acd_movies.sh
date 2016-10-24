#!/bin/bash


local_dir_tv=/mnt/MrU/Videos/Series
local_dir_movies=/mnt/MrU/Videos/Movies
log=/home/mal/Scripts/logs/log.rclone_movies
exclude=/home/mal/Scripts/rclone/.rclone_exclude
remote_dir_tv=acd:Videos/Series
remote_dir_movies=acd:Videos/Movies


date >> $log
echo "Movies Sync" >> $log

/usr/bin/rclone -v --stats 5m0s --transfers 3 --exclude-from $exclude --log-file $log copy $local_dir_movies $remote_dir_movies

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

