#!/bin/bash

msg=$HOME/Scripts/shodan/msg.text
old=$HOME/Scripts/shodan/old.text
dif=$HOME/Scripts/shodan/dif.text
ExtIP=`shodan myip`
pushover_app=$HOME/Scripts/.dontsync/pushover_app_shodan
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

mv $msg $old
shodan host $ExtIP > $msg
diff $msg $old > $dif

if [[ -s $dif ]] ; then
echo "$dif has data."
echo "Sending message to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=1" \
  --form-string "message=`cat $msg`" \
  https://api.pushover.net/1/messages.json

else
echo "$dif is empty."
fi ;

exit
