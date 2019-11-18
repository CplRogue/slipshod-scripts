#!/bin/bash

## Green Light is on PIN 11
## Yelow Light is on PIN 13
## Red Light is on PIN 15
## Buzzer is on PIN 16 

#gpio -v

gpio -g mode 23 out

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
gpio -g write 23 1
sleep .1
gpio -g write 23 0
sleep .1
gpio -g write 23 1
sleep .1
gpio -g write 23 0
