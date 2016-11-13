#!/bin/bash

acd_ls_new=$HOME/Scripts/pushover/Series/new.text
acd_ls_new_sort=$HOME/Scripts/pushover/Series/new_sort.text
acd_ls_old_sort=$HOME/Scripts/pushover/Series/old_sort.text
acd_ls_diff=$HOME/Scripts/pushover/Series/diff.text
acd_ls_wc=$HOME/Scripts/pushover/Series/wc.text
acd_ls_msg=$HOME/Scripts/pushover/Series/msg.text
acd_size=$HOME/Scripts/pushover/Series/size.text
pushover_app=$HOME/Scripts/.dontsync/pushover_app_acd
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr


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
  --form-string "priority=-2" \
  --form-string "message=`cat $acd_ls_msg`" \
  https://api.pushover.net/1/messages.json

else
echo "$acd_ls_diff is empty."
fi ;

exit
