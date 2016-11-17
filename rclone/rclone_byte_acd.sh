#!/bin/bash


local_dir_tv=$HOME/media/Series/
log=$HOME/scripts/logs/log.rclone
exclude=.DS_Store
remote_dir_tv=acd:Videos/Series/
list=$HOME/scripts/rclone/list.text
list2=$HOME/scripts/rclone/list_lastrun.text
list_number=$HOME/scripts/rclone/number.text
new_files=$HOME/scripts/rclone/new.text
mesg=$HOME/scripts/bash_scraps/rm_old/msg.text
pushover_app=$HOME/scripts/.dontsync/pushover_app_rclone
pushover_usr=$HOME/scripts/.dontsync/pushover_usr

#Check for new files
cat $list > $list2
/usr/bin/find $HOME/media/Series/* -type f | cut -d "/" -f 8- | grep -v '^[0-9]' > $list
diff $list $list2 > $new_files

if [[ -s $new_files ]] ; then
echo "$new_files has data."

#If new files run rclone
date >> $log
echo "TV Sync" >> $log
/usr/local/bin/rclone --stats 5m0s --exclude $exclude --log-file $log copy $local_dir_tv $remote_dir_tv
date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

#Created and send push notification
cat $new_files | grep -v '^[0-9]'| wc -l > $list_number
echo "`cat $list_number` New Files rcloned to ACD:" > $mesg
cat $new_files | cut -d "/" -f 8- | grep -v '^[0-9]' | sed 's/<//' | cut -d " " -f 2- >> $mesg

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $mesg`" \
  https://api.pushover.net/1/messages.json

#If no new files exit
else
echo "$new_files is empty."
exit
fi ;
