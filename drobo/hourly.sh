#!/bin/bash

MrU=/mnt/MrU/Backups/Plex
Miranda=/mnt/MrU/Delete/Miranda/
log=$HOME/Scripts/logs/log.drobo_backup
totalfiles=$HOME/Scripts/drobo/tmp/total.txt
number=$HOME/Scripts/drobo/tmp/number.txt
msgs=$HOME/Scripts/drobo/tmp/msgs
hourly=$HOME/Scripts/drobo/tmp/hourly
pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

#du -ah $MrU > $totalfiles
#cat $totalfiles | wc -l > $number

#echo "$(tail -1 $totalfiles)" > $msgs
#echo "Started $(date +"%Y-%m-%d %H:%M")" >> $msgs
#echo "Total # of Files: $(cat $number)" >> $msgs

#date >> $log
#echo "Drobo Backup Sync" > $log
#/usr/bin/rsync -rizcvIPe --log-file=$log $MrU $Miranda  
#/usr/bin/rsync -rizcvIPe --log-file=$log $MrU $Miranda > $log

head -n 3 $msgs > $hourly
echo "Total Files Synced: $(cat $log | wc -l)" >> $hourly

#date >> $log
#echo "done" >> $log
#echo "Finished > Exiting" >> $log
#echo "" >> $log

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $hourly`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

exit 0
