#!/bin/bash

stats=`head -n 1 /home/pi/WeatherStats.txt | sed 's/\.//'`
rainfall=`head -n 1 /home/pi/WeatherStats.txt`
new=`head -n 1 /home/pi/WeatherStats.txt | sed 's/\.//'`
old=/home/pi/Scripts/rain/tmp/old.txt
msgs=/home/pi/Scripts/rain/tmp/msgs.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_rain
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

echo " "
echo Rainfall $rainfall
echo Stats $stats
echo New $new
echo Old $(/bin/cat $old)
echo " "

if (( $new > $(/bin/cat $old) )); then
   echo "It is Raining!" > $msgs
   echo Current Rainfall $(zsh -c 'echo $(('$rainfall'*0.03937008))' | cut -c1-5) >> $msgs
   cat $msgs
   curl -s \
      --form-string "token=`cat $pushover_app`" \
      --form-string "user=`cat $pushover_usr`" \
      --form-string "priority=1" \
      --form-string "sound=bugle" \
      --form-string "message=`cat $msgs`" \
   https://api.pushover.net/1/messages.json
fi

echo " "
echo Stats $stats
echo New $new
echo Old $(/bin/cat $old)

echo $stats > $old
echo Old $(/bin/cat $old)
exit 0

