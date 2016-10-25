#!/bin/bash

result=$HOME/Scripts/speedtest/results.text
pushover_app=/home/mal/Scripts/.dontsync/pushover_app_speedtest
pushover_usr=/home/mal/Scripts/.dontsync/pushover_usr

$HOME/Scripts/speedtest/speedtest_cli.py --secure --simple > $result

if [[ -s $result ]] ; then
echo $result
#exit
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "message=`cat $result`" \
  https://api.pushover.net/1/messages.json

else
echo "$result is empty."
fi ;

exit
