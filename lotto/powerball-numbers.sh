#!/bin/bash

powerball=$HOME/Scripts/lotto/tmp/powerball-numbers.txt
numbers=$HOME/Scripts/lotto/tmp/pb-numbers.txt
pbnumber=$HOME/Scripts/lotto/tmp/pb-number.txt
lastnightnumbers=$HOME/Scripts/lotto/tmp/lnpb-number.txt
yourpbnumbers=$HOME/Scripts/lotto/tmp/yourpbnumbers.txt

pushover_app=$HOME/Scripts/.dontsync/pushover_app_lotto
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
msg=$HOME/Scripts/lotto/tmp/pbmsg-numbers.txt

#wget -qO- https://www.powerball.net/numbers/ > $powerball
#grep 'class="ball"' $powerball | head -n 5 | sed 's/[^0-9]*//g' > $numbers
#grep 'class="powerball"' $powerball | head -n 1 | sed 's/[^0-9]*//g' | sed 's/^/PB:/' > $pbnumber
wget -qO- https://nclottery.com/powerball > $powerball
grep ResultsPowerball $powerball | tail -n 7 | head -n 5 | cut -c 67- | sed 's/[^0-9]*//g' > $numbers
grep 'class="ball powerball"' $powerball | head -n 1 | cut -c 63- | sed 's/[^0-9]*//g' | sed 's/^/PB:/' > $pbnumber
cat $pbnumber >> $numbers
cat $numbers | sed '$!s/$/, /' | tr -d '\n' > $lastnightnumbers

echo "Last night's Powerball Numbers:" > $msg
cat $lastnightnumbers >> $msg
echo " " >> $msg
echo "Your Numbers:" >> $msg
cat $yourpbnumbers >> $msg

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=0" \
  --form-string "message=`cat $msg`" \
  https://api.pushover.net/1/messages.json

echo " " 
cat $msg

exit 0
