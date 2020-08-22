#!/bin/bash

lf_new=$HOME/Scripts/large_files/temp/new.text
lf_sortsize=$HOME/Scripts/large_files/temp/sortsize.text
lf_grepped=$HOME/Scripts/large_files/temp/grepped.text
lf_head=$HOME/Scripts/large_files/temp/head.text
lf_head_old=$HOME/Scripts/large_files/temp/head_old.text
lf_diff=$HOME/Scripts/large_files/temp/head_diff.text
lf_wc=$HOME/Scripts/large_files/temp/wc.text
lf_base=$HOME/Scripts/large_files/temp/base_msg.text
lf_msg=$HOME/Scripts/large_files/temp/msg.text
error_log=$HOME/Scripts/large_files/errors.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_lf
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr


#find /mnt/MrU/Videos/Series -type f -printf '%s %p\n' | sort -nr | grep -v "Game of Thrones" | grep -v "Band of Brothers" | grep -v "Blue Planet II" | head -10



find /mnt/MrU/Videos/Series -type f -printf '%s %p\n' > $lf_new
cat $lf_new | sort -nr > $lf_sortsize

cat $lf_sortsize | grep -v "Game of Thrones" | grep -v "Band of Brothers" | grep -v "Blue Planet II" > $lf_grepped

cp $lf_head $lf_head_old
cat $lf_grepped | head -10 | cut -d " " -f 3- | grep -v '^[0-9]' | sed 's/\//,/g' | sed 's/.*,//' > $lf_head
diff $lf_head $lf_head_old > $lf_diff


echo "Change in large files in Series Directory on Drobo. Check to see if the new large files should be replaced." > $lf_msg

if [[ -s $lf_diff ]] ; then
echo "$lf_diff has data."
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=0" \
  --form-string "message=`cat $lf_msg`" \
  https://api.pushover.net/1/messages.json

else
echo "$lf_diff is empty."
fi ;

exit
