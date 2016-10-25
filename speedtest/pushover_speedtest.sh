#!/bin/bash

pushover_result=/home/mal/Scripts/speedtest/pushover_results
pushover_app=/home/mal/Scripts/.dontsync/pushover_app_speedtest
pushover_usr=/home/mal/Scripts/.dontsync/pushover_usr

#/usr/bin/speedtest-cli --secure --simple > $pushover_result
/usr/bin/speedtest-cli --simple > $pushover_result

if [[ -s $pushover_result ]] ; then
echo "$pushover_result has data."
#exit
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "message=`cat $pushover_result`" \
  https://api.pushover.net/1/messages.json

else
echo "$pushover_result is empty."
fi ;

exit
