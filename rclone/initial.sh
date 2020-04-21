#!/bin/bash

log=$HOME/Scripts/logs/log.rclone.initial
level=INFO
exclude=.DS_Store
local_dir_backups=/mnt/MrU/Backups/JottaCloud_Backups
local_dir_mature=/mnt/MrU/Videos/Mature
local_dir_movies=/mnt/MrU/Videos/Movies
local_dir_tv=/mnt/MrU/Videos/Series
remote_dir_backups=bac:Backups
remote_dir_mature=bac:Videos/Mature/
remote_dir_movies=bac:Videos/Movies/
remote_dir_tv=bac:Videos/Series/

#rclone Backups
#rclone sync $local_dir_backups $remote_dir_backups --backup-dir=bac:Delete/Backups --log-file=$log --log-level $level --exclude $exclude

#rclone tv series
/usr/bin/rclone sync $local_dir_tv $remote_dir_tv --backup-dir=bac:Delete/Videos/Series --log-file=$log --log-level $level --stats 5m --exclude $exclude

#rclone mature
/usr/bin/rclone sync $local_dir_mature $remote_dir_mature --backup-dir=bac:Delete/Videos/Mature --log-file=$log --log-level $level --stats 5m --exclude $exclude

#rclone movies
/usr/bin/rclone sync $local_dir_movies $remote_dir_movies --backup-dir=bac:Delete/Videos/Movies --log-file=$log --log-level $level --stats 5m --exclude $exclude
