#!/bin/bash

## Green Light is on PIN 11
## Yelow Light is on PIN 13
## Red Light is on PIN 15

#gpio -v

#Yellow Light ON
echo "Green Light is BCM 17"
echo "Yellow Light is BCM 27"
echo "Red Light is BCM 22"
gpio -g mode 27 out
gpio -g write 27 1
#Green Light OFF
gpio -g write 17 0
#Red Light OFF
gpio -g write 22 0
/home/pi/Scripts/stoplight/buzzerylw.sh

gpio readall
