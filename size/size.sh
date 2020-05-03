#!/bin/bash

size=$HOME/Scripts/size/tmp/last.size
pushover_app=$HOME/Scripts/.dontsync/pushover_app_lf
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

#cd /mnt/MrU/Videos
cd /mnt
du -hs MrU/Videos > $size
du -hs MrU/Videos/Mature >> $size
du -hs MrU/Videos/Movies >> $size
du -hs MrU/Videos/Series >> $size

cat $size

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $size`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

exit
