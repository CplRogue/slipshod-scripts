#!/bin/bash

## Green Light is on PIN 11
## Yelow Light is on PIN 13
## Red Light is on PIN 15
## Buzzer is on PIN 16 

#gpio -v

sleep 10
#sleep 1
#echo "Turn on Yellow Light"
source /home/pi/Scripts/stoplight/turnligthyellow.sh
sleep 2 
#echo "Turn on Red Light"
/home/pi/Scripts/stoplight/turnligthred.sh
sleep 2 
#echo "Turn on Green Light"
/home/pi/Scripts/stoplight/turnligthgreen.sh
