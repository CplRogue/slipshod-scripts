#!/bin/bash

log=$HOME/Scripts/logs/log.rclone-drobo
message=$HOME/Scripts/drobo/tmp/last.msg
pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr


msg1=`cat $log | grep Transferred | tail -2 | head -1 | cut -f1,3 -d,`
#msg2=`cat $log | grep Transferred | tail -1`
msg3=`cat $log | grep Elapsed | tail -1`
msg4=`cat $log | grep Transferred | tail -2 | head -1 | cut -f4 -d,`
#/usr/bin/rclone size bac:Videos/Mature > $size
#/usr/bin/rclone size bac:Videos/Movies > $size
#/usr/bin/rclone size bac:Videos/Series > $size
#msg5=`cat $size | head -1`
#msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
#msg7=`cat $mrusize | grep Mature`
#msg7=`cat $mrusize | grep Movies`
#msg7=`cat $mrusize | grep Series`
#echo "::Data::  bac:Videos/Mature" > $message
#echo "::Data::  bac:Videos/Movies" > $message
echo "::Data::  Drobo:Sync" > $message
echo $msg1 >> $message
#echo $msg2 >> $message
echo $msg3 >> $message
echo $msg4 >> $message
#echo $msg5 >> $message
#echo $msg6 >> $message
#echo $msg7 >> $message
#echo "Current File" >> $message
tail -n 100 $log | grep -A 1 Transferring | tail -n 2 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
