#!/bin/bash

pinging=`ping -c 3 10.0.1.140`
now=$HOME/Scripts/ping/tmp/wx_now.txt
last=$HOME/Scripts/ping/tmp/wx_last.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_ping
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

echo $pinging > $now

#Host is down
if grep -q "100% packet loss" "$now"; then
	if grep -q "100% packet loss" "$last"; then
		exit 0
	else
	echo "WX is down"
   curl -s \
      --form-string "token=`cat $pushover_app`" \
      --form-string "user=`cat $pushover_usr`" \
      --form-string "sounf=spacealarm" \
      --form-string "priority=1" \
      --form-string "message=WX is DOWN" \
   https://api.pushover.net/1/messages.json
	fi
fi

#Host is up
if ! grep -q "100% packet loss" "$now"; then
	if ! grep -q "100% packet loss" "$last"; then
		exit 0
	else
	echo "WX is up"
   curl -s \
      --form-string "token=`cat $pushover_app`" \
      --form-string "user=`cat $pushover_usr`" \
      --form-string "sounf=spacealarm" \
      --form-string "priority=1" \
      --form-string "message=WX is UP" \
   https://api.pushover.net/1/messages.json
	fi
fi

echo " "

echo $pinging > $last

exit 0

