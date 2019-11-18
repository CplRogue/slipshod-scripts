#!/bin/bash

## Green Light is on PIN 11
## Yelow Light is on PIN 13
## Red Light is on PIN 15

#gpio -v

#Red Light ON
echo "Green Light is BCM 17"
echo "Yellow Light is BCM 27"
echo "Red Light is BCM 22"
gpio -g mode 22 out
gpio -g write 22 1
#Green Light OFF
gpio -g write 17 0
#Yellow Light OFF
gpio -g write 27 0
/home/pi/Scripts/stoplight/buzzerup.sh

gpio readall
