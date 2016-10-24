#!/bin/bash

acd_ls_new=/home/mal/Scripts/pushover/Series/new.txt
acd_ls_new_sort=/home/mal/Scripts/pushover/Series/new_sort.txt
acd_ls_old_sort=/home/mal/Scripts/pushover/Series/old_sort.txt
acd_ls_diff=/home/mal/Scripts/pushover/Series/diff.txt
acd_ls_wc=/home/mal/Scripts/pushover/Series/wc.txt
acd_ls_msg=/home/mal/Scripts/pushover/Series/msg.txt
acd_size=/home/mal/Scripts/pushover/Series/size.txt
pushover_app=/home/mal/Scripts/.dontsync/pushover_app_acd
pushover_usr=/home/mal/Scripts/.dontsync/pushover_usr


mv $acd_ls_new_sort $acd_ls_old_sort
/usr/bin/rclone ls acd:Videos/Series > $acd_ls_new
sort $acd_ls_new > $acd_ls_new_sort
diff $acd_ls_new_sort $acd_ls_old_sort | tail -n +2 | cut -d " " -f 3- | grep -v '^[0-9]' | sed 's/\//,/g' | sed 's/.*,//' > $acd_ls_diff

cat $acd_ls_diff | wc -l > $acd_ls_wc

/usr/bin/rclone size acd:Videos/Series > $acd_size

cat $acd_size > $acd_ls_msg
echo "" >> $acd_ls_msg
echo "`cat $acd_ls_wc` New File(s) in ACD/Series:" >> $acd_ls_msg
cat $acd_ls_diff >> $acd_ls_msg

#exit

if [[ -s $acd_ls_diff ]] ; then
echo "$acd_ls_diff has data."
#exit
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "message=`cat $acd_ls_msg`" \
  https://api.pushover.net/1/messages.json

else
echo "$acd_ls_diff is empty."
fi ;

exit
