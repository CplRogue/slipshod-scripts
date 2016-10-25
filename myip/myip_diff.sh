#!/bin/bash

ExtIP=`cat $HOME/Scripts/.dontsync/ExternalIP`
HOMEURL=`cat $HOME/Scripts/.dontsync/HomeURL`
wrExtIP=$HOME/Scripts/.dontsync/ExternalIP
msg=$HOME/Scripts/myip/msg.text
old=$HOME/Scripts/myip/old.text
diff=$HOME/Scripts/myip/diff.text
pushover_app=$HOME/Scripts/.dontsync/pushover_app_homeip
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

mv $msg $old

echo ""

#if [ `wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'` = $ExtIP ] ; then echo "matches" ; else echo "IP Addresses do not match"; fi

HOMEIP=`dig $HOMEURL +short`
MYIP=`wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`

echo ""
echo External IP Address is: $MYIP
echo $HOMEURL is: $HOMEIP
echo ""

echo "" > $msg
echo External IP Address is: $MYIP >> $msg
echo $HOMEURL is: $HOMEIP >> $msg
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
