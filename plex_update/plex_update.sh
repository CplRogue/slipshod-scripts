#!/bin/bash


log=$HOME/Scripts/logs/log.plex
link='https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-i686&distro=ubuntu&X-Plex-Token=tBj6Z4NhwXhQupTpZ7cJ'

date >> $log

wget $link -O latest.dep
dpkg -i latest.dep

