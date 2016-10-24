#!/bin/bash

ExtIP=`cat /home/mal/Scripts/.dontsync/ExternalIP`

echo ""

if [ `wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'` = $ExtIP ] ; then echo "matches" | pkill deluged ; else echo "IP Addresses do not match"; fi

HOMETHEWARESNET=`dig home.thewares.net +short`
MYIP=`wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`

echo ""
echo External IP Address is: $MYIP
echo home.thewares.net is: $HOMETHEWARESNET
echo ""
