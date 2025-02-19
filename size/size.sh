#!/bin/bash

size=$HOME/Scripts/size/tmp/last.size
pushover_app=$HOME/Scripts/.dontsync/pushover_app_lf
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

cd /mnt/Media
du -hs Videos > $size
du -hs Videos/Anime >> $size
du -hs Videos/Daily >> $size
du -hs Videos/Kids >> $size
du -hs Videos/Mature >> $size
du -hs Videos/Movies >> $size
du -hs Videos/Series >> $size
du -hs Videos/Series-International >> $size
du -hs Videos/TeslaCam >> $size

cat $size

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $size`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

cd /mnt/QBC
find . -name ".DS_Store" -print -type f -delete

exit
