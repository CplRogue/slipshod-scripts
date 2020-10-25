#!/bin/bash

secondary_drobo=/mnt/Lenore

log=$HOME/Scripts/logs/log.rsync-drobo
message=$HOME/Scripts/drobo/tmp/last.msg
size=$HOME/Scripts/drobo/tmp/last.size
mrusize=$HOME/Scripts/size/tmp/last.size
pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi


msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
#/usr/bin/rclone size $secondary_drobo > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
msg7=`cat $mrusize | head -n 1`
echo "::Drobo Sync::" > $message
echo $msg1 >> $message
echo $msg3 >> $message
echo $msg4 >> $message
#echo $msg5 >> $message
#echo $msg6 >> $message
#echo $msg7 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

exit 0
