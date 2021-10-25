#!/bin/bash

megamillions=$HOME/Scripts/lotto/tmp/megamillions.txt
math=$HOME/Scripts/lotto/tmp/mmmath.txt
math2=$HOME/Scripts/lotto/tmp/mmmath2.txt
prize=$HOME/Scripts/lotto/tmp/mmprize.txt
cash=$HOME/Scripts/lotto/tmp/mmcash.txt
payout=$HOME/Scripts/lotto/tmp/mmpayout.txt

pushover_app=$HOME/Scripts/.dontsync/pushover_app_lotto
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
msg=$HOME/Scripts/lotto/tmp/mmmsg.txt


wget -qO- https://nclottery.com/megamillions > $megamillions
grep MMPrize $megamillions > $prize
grep MMCash $megamillions > $cash

echo "Tonight's Mega Millions Payout:" > $msg
cat $prize | cut -d">" -f2 | rev | cut -c7- | rev | awk '{print "Jackpot "$0}' >> $msg
cat $cash | cut -d">" -f2 | rev | cut -c7- | rev >> $msg
cat $cash | cut -d">" -f2 | rev | cut -c7- | rev | tr -d -c .0-9 > $math
cat $math | rev | cut -c1- | rev > $math2
math3=`cat $math2 | rev | cut -c1- | rev`
math4=`cat $math2 | awk '{printf "%.0f\n", $1}'`
ksh -c 'echo $(('$math3'*0.57))' | awk '{print "After Taxes $"$0}' | awk '{print $0" Million"}' >> $msg

if [ `echo $math4` -lt 350 ]; then
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
