#!/bin/bash

megamillions=$HOME/Scripts/lotto/tmp/megamillions-numbers.txt
numbers=$HOME/Scripts/lotto/tmp/mm-numbers.txt
mmnumber=$HOME/Scripts/lotto/tmp/mm-number.txt
lastnightnumbers=$HOME/Scripts/lotto/tmp/lnmm-number.txt
yournumbers=$HOME/Scripts/lotto/tmp/yourmmnumbers.txt

pushover_app=$HOME/Scripts/.dontsync/pushover_app_lotto
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
msg=$HOME/Scripts/lotto/tmp/mmmsg-numbers.txt

wget -qO- https://nclottery.com/mega-millions > $megamillions
#grep 'class="ball"' $megamillions | head -n 5 | sed 's/[^0-9]*//g' | cut -c 4- > $numbers
#grep 'class="ball megaball"' $megamillions | head -n 1 | sed 's/[^0-9]*//g' | cut -c 3- | sed 's/^/PB:/' > $mmnumber
grep ResultsMegaMillions $megamillions | tail -n 7 | head -n 5 | cut -c 66- |  sed 's/[^0-9]*//g' > $numbers
grep 'class="ball megaball"' $megamillions | head -n 1 | cut -c 66- | sed 's/[^0-9]*//g' | sed 's/^/PB:/' > $mmnumber
cat $mmnumber >> $numbers
cat $numbers | sed '$!s/$/, /' | tr -d '\n' > $lastnightnumbers

echo "Last night's Megamillions Numbers:" > $msg
cat $lastnightnumbers >> $msg
echo " " >> $msg
echo "Your Numbers:" >> $msg
cat $yournumbers >> $msg

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=0" \
  --form-string "message=`cat $msg`" \
  https://api.pushover.net/1/messages.json

echo " " 
cat $msg

exit 0
