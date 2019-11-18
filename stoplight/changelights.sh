#!/bin/bash

## Green Light is on PIN 11
## Yelow Light is on PIN 13
## Red Light is on PIN 15

TIME=$(date +"%Y-%m-%d-%H%M")
LOG=/home/pi/Scripts/Logs/stoplight.log
STATUS=/home/pi/Scripts/stoplight/tmp/lastlightstatus.txt
#echo "Status is $STATUS"

#GRN=`curl -s http://stoplight.bac.edu/xymon/Network/Network.html | grep favicon-green.ico`
#YLW=`curl -s http://stoplight.bac.edu/xymon/Network/Network.html | grep favicon-yellow.ico`
#RED=`curl -s http://stoplight.bac.edu/xymon/Network/Network.html | grep favicon-red.ico`
GRN=`curl -s http://127.0.0.1/xymon/Network/Network.html | grep favicon-green.ico`
YLW=`curl -s http://127.0.0.1/xymon/Network/Network.html | grep favicon-yellow.ico`
RED=`curl -s http://127.0.0.1/xymon/Network/Network.html | grep favicon-red.ico`

#echo "Stoplight before export is $STOPLIGHT"
export STOPLIGHT=`cat $STATUS`
#echo "Stoplight after export is $STOPLIGHT"

#gpio -v

if [ -z "$GRN" ]
then
      echo "Green light is off"
else
      if [ "$STOPLIGHT" = "Greenlight" ]
	  then
		echo "Light is already Green"
          exit
      fi
      export STOPLIGHT="Greenlight"
      echo $STOPLIGHT > $STATUS
      echo "Turning Green light on"
      echo "$TIME - Turning Green ligt on" >> $LOG
	  #Green Light ON
		gpio -g mode 17 out
		gpio -g write 17 1
                /home/pi/Scripts/stoplight/buzzerdown.sh
	  #Yellow Light OFF
		gpio -g write 27 0
	  #Red Light OFF
		gpio -g write 22 0
fi

if [ -z "$YLW" ]
then
      echo "Yellow light is off"
else
      if [ "$STOPLIGHT" = "Yellowlight" ]
	  then
		echo "Light is already Yellow"
          exit
      fi
      export STOPLIGHT="Yellowlight"
      echo $STOPLIGHT > $STATUS
      echo "Turning Yellow light on"
      echo "$TIME - Turning Yellow ligt on" >> $LOG
	  #Yellow Light ON
		gpio -g mode 27 out
		gpio -g write 27 1
                /home/pi/Scripts/stoplight/buzzerylw.sh
	  #Green Light OFF
		gpio -g write 17 0
	  #Red Light OFF
		gpio -g write 22 0
fi

if [ -z "$RED" ]
then
      echo "Red light is off"
else
      if [ "$STOPLIGHT" = "Redlight" ]
	  then
		echo "Light is already Red"
          exit
      fi
      export STOPLIGHT="Redlight"
      echo $STOPLIGHT > $STATUS
      echo "Turning Red light on"
      echo "$TIME - Turning Red ligt on" >> $LOG
	  #Red Light ON
		gpio -g mode 22 out
		gpio -g write 22 1
                /home/pi/Scripts/stoplight/buzzerup.sh
	  #Green Light OFF
		gpio -g write 17 0
	  #Yellow Light OFF
		gpio -g write 27 0
fi

gpio readall
echo Stoplight is set to $STOPLIGHT
echo "lastlightstatus.txt contains $STOPLIGHT"
