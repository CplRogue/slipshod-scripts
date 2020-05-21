#!/bin/bash

log=$HOME/Scripts/logs/log.rclone
level=INFO
exclude=.DS_Store
message=$HOME/Scripts/rclone/tmp/last.msg
size=$HOME/Scripts/rclone/tmp/last.size
mrusize=$HOME/Scripts/size/tmp/last.size
local_dir_backups=/mnt/MrU/Backups/JottaCloud_Backups
local_dir_mature=/mnt/MrU/Videos/Mature
local_dir_movies=/mnt/MrU/Videos/Movies
local_dir_tv=/mnt/MrU/Videos/Series
remote_dir_backups=bac:Backups
remote_dir_mature=bac:Videos/Mature/
remote_dir_movies=bac:Videos/Movies/
remote_dir_tv=bac:Videos/Series/
pushover_app=$HOME/Scripts/.dontsync/pushover_app_rclone
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

#rclone Backups
#rclone sync $local_dir_backups $remote_dir_backups --backup-dir=bac:Delete/Backups --log-file=$log --log-level $level --exclude $exclude
msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size bac:Backups > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
echo "::Data:: bac:Backups" > $message
echo $msg1 >> $message
echo $msg2 >> $message
echo $msg3 >> $message
echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

#rclone tv series
#rclone sync $local_dir_tv $remote_dir_tv --backup-dir=bac:Delete/Videos/Series --log-file=$log --log-level $level --stats 5m --exclude $exclude --min-age 7d
msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size bac:Videos/Series > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | grep Series`
echo "::Data:: bac:Videos/Series" > $message
echo $msg1 >> $message
echo $msg2 >> $message
echo $msg3 >> $message
echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
echo $msg7 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

#rclone mature
#rclone sync $local_dir_mature $remote_dir_mature --backup-dir=bac:Delete/Videos/Mature --log-file=$log --log-level $level --stats 5m --exclude $exclude --min-age 7d
msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size bac:Videos/Mature > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | grep Mature`
echo "::Data:: bac:Videos/Mature" > $message
echo $msg1 >> $message
echo $msg2 >> $message
echo $msg3 >> $message
echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
echo $msg7 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

#rclone movies
#rclone sync $local_dir_movies $remote_dir_movies --backup-dir=bac:Delete/Videos/Movies --log-file=$log --log-level $level --stats 5m --exclude $exclude
msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size bac:Vidoes/Movies > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | grep Movies`
echo "::Data:: bac:Videos/Movies" > $message
echo $msg1 >> $message
echo $msg2 >> $message
echo $msg3 >> $message
echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
echo $msg7 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

exit 0
