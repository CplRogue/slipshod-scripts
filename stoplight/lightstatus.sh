#!/bin/bash

GRN=`curl -s http://stoplight.bac.edu/xymon/Network/Network.html | grep favicon-green.ico`
YLW=`curl -s http://stoplight.bac.edu/xymon/Network/Network.html | grep favicon-yellow.ico`
RED=`curl -s http://stoplight.bac.edu/xymon/Network/Network.html | grep favicon-red.ico`

gpio -v
gpio readall

echo " "
if [ -z "$GRN" ]
then
      #echo "\$GRN is empty"
      echo "Green light is off"
else
      echo "Green light is on"
fi

if [ -z "$YLW" ]
then
      #echo "\$YLW is empty"
      echo "Yellow light is off"
else
      echo "Yellow light is on"
fi

if [ -z "$RED" ]
then
      #echo "\$RED is empty"
      echo "Red light is off"
else
      echo "Red light is on"
fi

#
#echo " "
#[  -z "$GRN" ] && echo "Green light is off" || echo "Green light is on"
#[  -z "$YLW" ] && echo "Yellow light is off" || echo "Yellow light is on"
#[  -z "$RED" ] && echo "Red light is off" || echo "Red light is on"
#
#echo " "
#echo $GRN
#echo $YLW
#echo $RED

