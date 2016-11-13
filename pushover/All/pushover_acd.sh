#!/bin/bash

acd_ls_msg=$HOME/Scripts/pushover/All/msg.text
acd_total=$HOME/Scripts/pushover/All/size.text
acd_movies=$HOME/Scripts/pushover/All/size_movies.text
acd_series=$HOME/Scripts/pushover/All/size_series.text
pushover_app=$HOME/Scripts/.dontsync/pushover_app_acd
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

echo "Collection Total Size"
/usr/bin/rclone size acd:Videos > $acd_total
echo ""
echo "Collection Total Size of Movies"
/usr/bin/rclone size acd:Videos/Movies > $acd_movies
echo ""
echo "Collection Total Size of Series"
/usr/bin/rclone size acd:Videos/Series > $acd_series

echo ""
echo "Creating Message Total"
echo "" > $acd_ls_msg
echo "Total in ACD:" >> $acd_ls_msg
cat $acd_total >> $acd_ls_msg
echo "" >> $acd_ls_msg
echo "Creating Message Movies"
echo "Total in ACD Movies:" >> $acd_ls_msg
cat $acd_movies >> $acd_ls_msg
echo "" >> $acd_ls_msg
echo "Creating Message Series"
echo "Total in ACD Series:" >> $acd_ls_msg
cat $acd_series >> $acd_ls_msg


echo "Sending message to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $acd_ls_msg`" \
  https://api.pushover.net/1/messages.json

echo "Exiting"
exit
