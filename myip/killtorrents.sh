#!/bin/bash

ExtIP=`cat $HOME/Scripts/.dontsync/ExternalIP`
HOMEURL=`cat $HOME/Scripts/.dontsync/HomeURL`

echo ""

if [ `wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'` = $ExtIP ] ; then echo "matches" | pkill deluged ; else echo "IP Addresses do not match"; fi

HOMEIP=`dig $HOMEURL +short`
MYIP=`wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`

echo ""
echo External IP Address is: $MYIP
echo $HOMEURL is: $HOMEIP
echo ""
