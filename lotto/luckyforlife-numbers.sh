#!/bin/bash

lucky4life=$HOME/Scripts/lotto/tmp/luckyforlife-numbers.txt
numbers=$HOME/Scripts/lotto/tmp/l4l-numbers.txt
l4lnumber=$HOME/Scripts/lotto/tmp/l4l-number.txt
lastnightnumbers=$HOME/Scripts/lotto/tmp/lnl4l-number.txt
yournumbers=$HOME/Scripts/lotto/tmp/yourl4lnumbers.txt
yournumberssorted=$HOME/Scripts/lotto/tmp/yourl4lnumbers-sorted.txt

pushover_app=$HOME/Scripts/.dontsync/pushover_app_lotto
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
msg=$HOME/Scripts/lotto/tmp/l4lmsg-numbers.txt

echo "wget"
wget -qO- https://nclottery.com/LuckyForLife > $lucky4life
echo "grep ball"
grep 'class="ball"' $lucky4life | head -n 5 | sed 's/[^0-9]*//g' | cut -c 5- > $numbers
echo "grep powerball"
#grep 'class="ball luckyball"' $lucky4life | head -n 1 | sed 's/[^0-9]*//g' | cut -c 4- | sed 's/^/PB:/' > $l4lnumber
grep 'class="ball luckyball"' $lucky4life | head -n 1 | sed 's/.*\(..........\)/\1/' | sed 's/[^0-9]*//g' | sed 's/^/PB:/' > $l4lnumber
echo "cat l4lnumber to numbers"
cat $l4lnumber >> $numbers
echo "cat numbers to ln-numbers"
cat $numbers | sed '$!s/$/, /' | tr -d '\n' > $lastnightnumbers

#winning=`comm -12 $numbers $yournumberssorted | wc -l | sed 's/ //g'`
winning=`grep -f  $numbers $yournumberssorted | wc -l | sed 's/ //g'`

echo "create msg"
#echo "Last night's Lucky For Life Numbers:" > $msg
echo "Lucky For Life Matching Numbers: $winning" > $msg
echo "Last Night's Numbers:" >> $msg
cat $lastnightnumbers >> $msg
echo " " >> $msg
echo "Your Numbers:" >> $msg
cat $yournumbers >> $msg
#echo "Matching Numbers: $winning" >> $msg


echo "send msg"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=0" \
  --form-string "message=`cat $msg`" \
  https://api.pushover.net/1/messages.json

echo " " 
cat $msg

exit 0
