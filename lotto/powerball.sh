#!/bin/bash

powerball=$HOME/Scripts/lotto/tmp/powerball.txt
math=$HOME/Scripts/lotto/tmp/pbmath.txt
math2=$HOME/Scripts/lotto/tmp/pbmath2.txt
prize=$HOME/Scripts/lotto/tmp/pbprize.txt
cash=$HOME/Scripts/lotto/tmp/pbcash.txt
payout=$HOME/Scripts/lotto/tmp/pbpayout.txt

pushover_app=$HOME/Scripts/.dontsync/pushover_app_lotto
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
msg=$HOME/Scripts/lotto/tmp/pbmsg.txt


wget -qO- https://nclottery.com/Powerball > $powerball
grep PBPrize $powerball > $prize
grep PBCash $powerball > $cash

echo "Tonight's Powerball Payout:" > $msg
cat $prize | cut -d">" -f2 | rev | cut -c7- | rev | awk '{print "Jackpot "$0}' >> $msg
cat $cash | cut -d">" -f2 | rev | cut -c7- | rev >> $msg
cat $cash | cut -d">" -f2 | rev | cut -c7- | rev | tr -d -c .0-9 > $math
cat $math | rev | cut -c1- | rev > $math2
math3=`cat $math2 | rev | cut -c1- | rev`
math4=`cat $math2 | awk '{printf "%.0f\n", $1}'`
ksh -c 'echo $(('$math3'*0.57))' | awk '{print "After Taxes $"$0}' | awk '{print $0" Million"}' >> $msg

echo $math4

if [ `echo $math4` -lt 150 ]; then
	exit
fi

curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=0" \
  --form-string "message=`cat $msg`" \
  https://api.pushover.net/1/messages.json

echo " " 
cat $msg

exit 0
