#!/bin/bash

## Green Light is on PIN 11
## Yelow Light is on PIN 13
## Red Light is on PIN 15
## Buzzer is on PIN 16 

#gpio -v

gpio -g mode 23 out

#gpio -g write 23 1
#sleep 1
#gpio -g write 23 0
#sleep .1
#gpio -g write 23 1
#sleep .9
#gpio -g write 23 0
#sleep .1
#gpio -g write 23 1
#sleep .8
#gpio -g write 23 0
#sleep .1
#gpio -g write 23 1
#sleep .7
#gpio -g write 23 0
#sleep .1
gpio -g write 23 1
sleep .6
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .5
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .4
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .3
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .2
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .1
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .1
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .1
gpio -g write 23 0
sleep .1


