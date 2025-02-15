#!/bin/bash

local_temp_dir=$HOME/Scripts/drobo_local/tmp

log=$HOME/Scripts/logs/log.unaslocal

#message_tv=$HOME/Scripts/rsync_pull/tmp/tv.msg

#pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
#pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

MrU2=/mnt/MrU/
#MrU2=/mnt/MrU/Backups/
#MrU2=/mnt/MrU/Music/
#MrU2=/mnt/MrU/Videos/
#MrU2=/mnt/MrU/Videos/Anime/
#MrU2=/mnt/MrU/Videos/Daily/
#MrU2=/mnt/MrU/Videos/Home-Movies/
#MrU2=/mnt/MrU/Videos/Kids/
#MrU2=/mnt/MrU/Videos/Mature/
#MrU2=/mnt/MrU/Videos/Movies/
#MrU2=/mnt/MrU/Videos/Series/
#MrU2=/mnt/MrU/Videos/Series-International/
#MrU2=/mnt/MrU/Videos/TeslaCam/
#MrU2=/mnt/MrU/Working/
#
QBC2=/mnt/QBC/
#QBC2=/mnt/QBC/Backups/
#QBC2=/mnt/QBC/Music/
#QBC2=/mnt/QBC/Videos/
#QBC2=/mnt/QBC/Videos/Anime/
#QBC2=/mnt/QBC/Videos/Daily/
#QBC2=/mnt/QBC/Videos/Home-Movies/
#QBC2=/mnt/QBC/Videos/Kids/
#QBC2=/mnt/QBC/Videos/Mature/
#QBC2=/mnt/QBC/Videos/Movies/
#QBC2=/mnt/QBC/Videos/Series/
#QBC2=/mnt/QBC/Videos/Series-International/
#QBC2=/mnt/QBC/Videos/TeslaCam/
#QBC2=/mnt/QBC/Working/

settings="--stats --human-readable --progress --exclude=QBC.txt --exclude=MrU.txt --exclude=.DS_Store --exclude=/.streams/ --exclude=/Do_Not_Sync/ --delete-during --size-only -rzv"
##
#dryrun=--dry-run
dryrun=

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then echo "Already running"; exit; fi

clear
echo "####################################################################"
echo "#                 Local UNAS Media Sync Script                    #"
echo "####################################################################"
echo " "
echo " "
echo " "
echo " "
echo "Checking to see if this script is already running"
echo " "
sleep 1

if [[ "$running" == *"pierus"* ]]
   then
	   echo "RSYNC is already runnning, exiting..."
           echo " "
           sleep 1
	   exit 0
   else	   
	   echo "This script not already running, will continue in 3 seconds"
	   sleep 1
	   echo "                                                  2 seconds"
	   sleep 1
	   echo "                                                  1 second "
	   sleep 1
fi

date >> $log

clear
echo "####################################################################"
echo "#                 Local UNAS Media Sync Script                    #"
echo "####################################################################"
echo " "
echo " "
echo "Starting local file transfer from Mr. Universe to Q.B. Cooler"
date
echo " "
echo "UNAS Local Sync"
echo "UNAS Local Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings $MrU2 $QBC2 $dryrun
date >> $log
echo "UNAS Local Sync Finished"
date
echo " "
echo "UNAS Local Sync Finished" >> $log
date >> $log
#echo "Drobo Local Sync Finished" > $message_tv
#tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_tv
#tv_exists=$(tail -n 3 $message_tv | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
#if [ -z "$tv_exists" ] 
#	then echo "Empty Drobo Local Message"
#else 
#curl -s \
#  --form-string "token=`cat $pushover_app`" \
#  --form-string "user=`cat $pushover_usr`" \
#  --form-string "priority=-2" \
#  --form-string "message=`cat $message_tv`" \
#  https://api.pushover.net/1/messages.json > /dev/null 2>&1
#fi

echo "Finished > Exiting" >> $log
date >> $log
echo "" >> $log


exit 0
