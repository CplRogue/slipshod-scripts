#!/bin/bash

#state=$(ssh pi@wx.local 'ls -al /home/pi/SkyWeather/state/WeatherStats.txt')
state=$(ssh pi@10.0.1.140 'ls -al /home/pi/SkyWeather/state/WeatherStats.txt')
now=$HOME/Scripts/ping/tmp/skyweather_state_now.txt
last=$HOME/Scripts/ping/tmp/skyweather_state_last.txt
stat=$HOME/Scripts/ping/tmp/skyweather_status.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_ping
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

echo "Last State was:"
cat $stat
cat $last
echo " "
echo $state > $now
echo "Current State is:"
cat $now

#Skyweather is down
if cmp -s "$now" "$last"; then
	if grep -q "DOWN" "$stat"; then
		echo "Status equals DOWN"
		exit 0
	else
   echo "SkyWeather is DOWN"
   echo "DOWN" > $stat
   curl -s \
      --form-string "token=`cat $pushover_app`" \
      --form-string "user=`cat $pushover_usr`" \
      --form-string "sounf=spacealarm" \
      --form-string "priority=1" \
      --form-string "message=SkyWeather is DOWN" \
   https://api.pushover.net/1/messages.json
   echo " "
fi
else
   echo " "
   echo "SkyWeather is UP"
   echo "UP" > $stat
fi

echo " "

echo "Writing $now to $last"
echo "Now:"
cat $now
echo "Last:"
cat $last
cat $now > $last
echo "New Last:"
cat $last

exit 0

