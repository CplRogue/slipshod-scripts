#!/bin/bash

log=$HOME/Scripts/logs/log.rclone
logtv=$HOME/Scripts/logs/log.rclonetv
logmature=$HOME/Scripts/logs/log.rclonemature
logmovies=$HOME/Scripts/logs/log.rclonemovies
level=INFO
exclude=.DS_Store
local_dir_mature=/mnt/Lenore/Videos/Mature
local_dir_movies=/mnt/Lenore/Videos/Movies
local_dir_tv=/mnt/Lenore/Videos/Series
remote_dir_mature=remote:Videos/Mature/
remote_dir_movies=remote:Videos/Movies/
remote_dir_tv=remote:Videos/Series/
message=$HOME/Scripts/restore_drobo/tmp/last.msg
exist=$HOME/Scripts/restore_drobo/tmp/exist.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_rclone
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

##Only use one
#dryrun=--dry-run
dryrun=

##Only use one
copysync=copy
#copysync=sync

#rclone tv
/usr/bin/rclone $copysync $remote_dir_tv $local_dir_tv --log-file=$logtv --log-level $level --stats 5m --exclude $exclude --retries 1 --size-only --drive-acknowledge-abuse $dryrun

echo "::Google Drive > Secondary Drobo TV::" > $message
tail -n 5 ~/Scripts/logs/log.rclonetv | grep -v INFO | awk '{$2=$2};1' >> $message

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

#rclone mature
#/usr/bin/rclone $copysync $remote_dir_mature $local_dir_mature --log-file=$logmature --log-level $level --stats 5m --exclude $exclude --retries 1 --size-only $dryrun
#
#echo "::Google Drive > Secondary Drobo Mature::" > $message
#tail -n 5 ~/Scripts/logs/log.rclonemature | grep -v INFO | awk '{$2=$2};1' >> $message
#
#cat $message | grep "Elapsed time: 0." > $exist
#if [[ -s $exist ]] ; then
#  echo "$exist for Backups is zero."
#else
#cat $message
#curl -s \
#  --form-string "token=`cat $pushover_app`" \
#  --form-string "user=`cat $pushover_usr`" \
#  --form-string "priority=-2" \
#  --form-string "message=`cat $message`" \
#  https://api.pushover.net/1/messages.json > /dev/null 2>&1
#fi ;

#rclone movies
/usr/bin/rclone $copysync $remote_dir_movies $local_dir_movies --log-file=$logmovies --log-level $level --stats 5m --exclude $exclude --retries 1 --size-only $dryrun


echo "::Google Drive > Secondary Drobo Movies::" > $message
tail -n 5 ~/Scripts/logs/log.rclonemovies | grep -v INFO | awk '{$2=$2};1' >> $message

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

exit 0
