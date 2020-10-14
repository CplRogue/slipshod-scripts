#!/bin/bash

log=$HOME/Scripts/logs/log.rclone
#log=/home/drware/Scripts/logs/log.rclone
level=INFO
exclude=.DS_Store
message=$HOME/Scripts/restore_drobo/tmp/last.msg
size=$HOME/Scripts/restore_drobo/tmp/last.size
exist=$HOME/Scripts/restore_drobo/tmp/exist
motd=$HOME/Scripts/restore_drobo/tmp/motd
mrusize=$HOME/Scripts/size/tmp/last.size
#message=/home/drware/Scripts/restore_drobo/tmp/last.msg
#size=/home/drware/Scripts/restore_drobo/tmp/last.size
#exist=/home/drware/Scripts/restore_drobo/tmp/exist
#motd=/home/drware/Scripts/restore_drobo/tmp/motd
#mrusize=/home/drware/Scripts/size/tmp/last.size
local_dir_backups=/mnt/Lenore/Backups/Plex
local_dir_mature=/mnt/Lenore/Videos/Mature
local_dir_movies=/mnt/Lenore/Videos/Movies
local_dir_tv=/mnt/Lenore/Videos/Series
remote_dir_backups=remote:Backups
remote_dir_mature=remote:Videos/Mature/
remote_dir_movies=remote:Videos/Movies/
remote_dir_tv=remote:Videos/Series/
pushover_app=$HOME/Scripts/.dontsync/pushover_app_rclone
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
#pushover_app=/home/drware/Scripts/.dontsync/pushover_app_rclone
#pushover_usr=/home/drware/Scripts/.dontsync/pushover_usr

##Only use one
#dryrun=--dry-run
dryrun=

#rclone Backups
#/usr/bin/rclone sync $local_dir_backups $remote_dir_backups --backup-dir=bac:Delete/Backups --log-file=$log --log-level $level --exclude $exclude $dryrun
#/usr/bin/rclone sync $remote_dir_backups $local_dir_backups --log-file=$log --log-level $level --exclude $exclude $dryrun
#msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg1=`cat $log | grep Transferred | tail -2 | cut -f1-3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size remote:Backups > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
echo "::Data:: Restore:Backups" > $message
echo $msg1 >> $message
#echo $msg2 >> $message
echo $msg3 >> $message
#ETA
#echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
cat $message | grep "Elapsed time: 0." > $exist
if [[ -s $exist ]] ; then
  echo "$exist for Backups is zero."
else
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi ;

#rclone tv series
#/usr/bin/rclone sync $local_dir_tv $remote_dir_tv --backup-dir=bac:Delete/Videos/Series --log-file=$log --log-level $level --stats 5m --exclude $exclude --min-age 7d $dryrun
#/usr/bin/rclone sync $remote_dir_tv $local_dir_tv --log-file=$log --log-level $level --stats 5m --exclude $exclude --min-age 7d $dryrun
#msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg1=`cat $log | grep Transferred | tail -2 | cut -f1-3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size remote:Videos/Series > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | grep Series`
echo "::Data:: Restore:Videos/Series" > $message
echo $msg1 >> $message
#echo $msg2 >> $message
echo $msg3 >> $message
#ETA
#echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
echo $msg7 >> $message
cat $message | grep "Elapsed time: 0." > $exist
if [[ -s $exist ]] ; then
  echo "$exist for Series is zero."
else
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi ;

#rclone mature
#/usr/bin/rclone sync $local_dir_mature $remote_dir_mature --backup-dir=bac:Delete/Videos/Mature --log-file=$log --log-level $level --stats 5m --exclude $exclude --min-age 7d $dryrun
/usr/bin/rclone sync $remote_dir_mature $local_dir_mature --log-file=$log --log-level $level --stats 5m --exclude $exclude --min-age 7d $dryrun
#msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg1=`cat $log | grep Transferred | tail -2 | cut -f1-3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size remote:Videos/Mature > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | grep Mature`
echo "::Data:: Restore:Videos/Mature" > $message
echo $msg1 >> $message
#echo $msg2 >> $message
echo $msg3 >> $message
#ETA
#echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
echo $msg7 >> $message
cat $message | grep "Elapsed time: 0." > $exist
if [[ -s $exist ]] ; then
  echo "$exist for Mature is zero."
else
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi ;

#rclone movies
#/usr/bin/rclone sync $local_dir_movies $remote_dir_movies --backup-dir=bac:Delete/Videos/Movies --log-file=$log --log-level $level --stats 5m --exclude $exclude $dryrun
/usr/bin/rclone sync $remote_dir_movies $local_dir_movies --log-file=$log --log-level $level --stats 5m --exclude $exclude $dryrun
#msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg1=`cat $log | grep Transferred | tail -2 | cut -f1-3 -d,`
msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
/usr/bin/rclone size remote:Videos/Movies > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | grep Movies`
echo "::Data:: Restore:Videos/Movies" > $message
echo $msg1 >> $message
#echo $msg2 >> $message
echo $msg3 >> $message
#ETA
#echo $msg4 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
echo $msg7 >> $message
cat $message | grep "Elapsed time: 0." > $exist
if [[ -s $exist ]] ; then
  echo "$exist for Movies is zero."
else
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi ;

sleep 30

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $motd`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

exit 0
