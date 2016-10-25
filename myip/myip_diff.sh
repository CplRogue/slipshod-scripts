#!/bin/bash

ExtIP=`cat /home/mal/Scripts/.dontsync/ExternalIP`
wrExtIP=/home/mal/Scripts/.dontsync/ExternalIP
msg=/home/mal/Scripts/myip/msg.text
old=/home/mal/Scripts/myip/old.text
diff=/home/mal/Scripts/myip/diff.text
pushover_app=/home/mal/Scripts/.dontsync/pushover_app_homeip
pushover_usr=/home/mal/Scripts/.dontsync/pushover_usr

mv $msg $old

echo ""

#if [ `wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'` = $ExtIP ] ; then echo "matches" ; else echo "IP Addresses do not match"; fi

HOMETHEWARESNET=`dig home.thewares.net +short`
MYIP=`wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`

echo ""
echo External IP Address is: $MYIP
echo home.thewares.net is: $HOMETHEWARESNET
echo ""

echo "" > $msg
echo External IP Address is: $MYIP >> $msg
echo home.thewares.net is: $HOMETHEWARESNET >> $msg
echo "" >> $msg

diff $msg $old > $diff

if [[ -s $diff ]] ; then
echo "$diff has data."
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "message=`cat $msg`" \
  https://api.pushover.net/1/messages.json

echo $MYIP > $wrExtIP

else
echo "$diff is empty."
fi ;

exit
