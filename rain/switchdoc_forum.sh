#!/bin/bash

rainfall=`head -n 1 /home/pi/SDL_Pi_SkyWeather/state/WeatherStats.txt`
new=`head -n 1 /home/pi/SDL_Pi_SkyWeather/state/WeatherStats.txt | sed 's/\.//'`
old=/home/pi/SDL_Pi_SkyWeather/static/old.txt
msgs=/home/pi/SDL_Pi_SkyWeather/static/msgs.txt


if (( $new > $(/bin/cat $old) )); then
   echo "It is Raining!" > $msgs
   echo Current Rainfall $(zsh -c 'echo $(('$rainfall'*0.03937008))' | cut -c1-5) >> $msgs
   cat $msgs
   curl -s \
      --form-string "token=PUSHOVER_APP_TOKEN" \
      --form-string "user=PUSHEOVER_USER_KEY" \
      --form-string "priority=1" \
      --form-string "message=`cat $msgs`" \
   https://api.pushover.net/1/messages.json
fi

echo $new > $old
exit 0
