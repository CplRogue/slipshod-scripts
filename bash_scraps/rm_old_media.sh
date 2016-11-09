#!/bin/bash

AGE_List=7 
#AGE_Remove should be 3 more than Age_List
AGE_Remove=13
log=$HOME/scripts/logs/log.rm_old_files
list=$HOME/scripts/bash_scraps/rm_old/list_old_files.text
list_number=$HOME/scripts/bash_scraps/rm_old/number.text
mesg=$HOME/scripts/bash_scraps/rm_old/msg.text
pushover_app=$HOME/scripts/.dontsync/pushover_app_rmOld
pushover_usr=$HOME/scripts/.dontsync/pushover_usr

#List Files to be removed
/usr/bin/find $HOME/media/* -mtime +$AGE_List -type f > $list
cat $list | wc -l > $list_number
echo "`cat $list_number` Media files older than $AGE_List days will be removed in 5 days or less:" > $mesg
cat $list | cut -d " " -f 3- | grep -v '^[0-9]' | sed 's/\//,/g' | sed 's/.*,//' >> $mesg

if [[ -s $list ]] ; then
echo "$list has data."
#exit
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "message=`cat $mesg`" \
  https://api.pushover.net/1/messages.json

else
echo "$list is empty."
exit
fi ;

#Remove files
date >> $log
echo "Delete Media Files  older than `echo $AGE_Remove` Days" >> $log
echo "" >> $log
#/usr/bin/find $HOME/media/* -mtime +$AGE -type f -delete >> $log
/usr/bin/find $HOME/media/* -mtime +$AGE_Remove -type f >> $log

echo "" >> $log
date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log
echo "" >> $log

exit
