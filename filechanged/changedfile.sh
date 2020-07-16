#!/bin/bash

today=$(date +%Y%m%d-%H%M)
file=
temp=$HOME/Scripts/bac_scripts/filechanged/tmp
backup=$HOME/Scripts/bac_scripts/filechanged/backup
new=$temp/new.txt
old=$temp/old.txt
updated=$temp/diff.txt
message=$temp/msg.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_changedfile
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

cp $new $old
cp $file $new
diff $new $old > $updated

if [[ -s $updated ]] ; then
echo "Bind has been updated" > $message
cat $updated | tail -n +2 >> $message
cat $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=0" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
  cp $new $backup/$today
else
  echo "$updated for Bind is zero."
fi ;
