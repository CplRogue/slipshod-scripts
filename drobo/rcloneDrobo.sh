#!/bin/bash

primary_drobo=/mnt/MrU
secondary_drobo=/mnt/Lenore

log=$HOME/Scripts/logs/log.rclone-drobo
level=INFO
exclude=.DS_Store
message=$HOME/Scripts/drobo/tmp/last.msg
size=$HOME/Scripts/drobo/tmp/last.size
exist=$HOME/Scripts/drobo/tmp/exist
motd=$HOME/Scripts/drobo/tmp/motd
mrusize=$HOME/Scripts/size/tmp/last.size
pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

##Only use one
#dryrun=--dry-run
dryrun=

# Copy or Sync?
#copyorsync=copy
copyorsync=sync

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

#rclone Backups
/usr/bin/rclone $copyorsync --retries 1 --size-only $primary_drobo $secondary_drobo --log-file=$log --log-level $level --exclude $exclude $dryrun

#generate message
msg1=`cat $log | grep Transferred | tail -2 | cut -f1-3 -d,`
msg3=`cat $log | grep Elapsed | tail -1`
/usr/bin/rclone size $secondary_drobo > $size
msg5=`cat $size | head -1`
msg6=`cat $size | tail -1 | cut -f1-4 -d ' '`
echo "::Drobo $copyorsync::" > $message
echo $msg1 >> $message
echo $msg3 >> $message
echo $msg5 >> $message
echo $msg6 >> $message
cat $message | grep "Elapsed time: 0." > $exist
#if [[ -s $exist ]] ; then
#  echo "$exist for Backups is zero."
#else
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
#fi ;

exit 0
