#!/bin/bash

local_temp_dir=$HOME/Scripts/drobo_local/tmp

log=$HOME/Scripts/logs/log.rsynclocal

#message_tv=$HOME/Scripts/rsync_pull/tmp/tv.msg

#pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
#pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

MrU=/mnt/MrU/
Lenore=/mnt/Lenore
MrU2=/mnt/MrU/Working/TeslaCam/
Lenore2=/mnt/Lenore/Working/TeslaCam

settings="--stats --progress --exclude=Lenore.txt --exclude=MrU.txt --exclude=/.streams/ --exclude=/Do_Not_Sync/ --exclude=/Working/ --delete-during --size-only -rzv"
settings2="--stats --progress --delete-during --size-only -rzv"
#settings="--stats --progress --exclude=Lenore.txt --exclude=MrU.txt --exclude=/.streams/ --exclude=/Backups/ --exclude=/Do_Not_Sync/ --include=/Working/TeslaCam/ --exclude=/Working/ --delete-during --size-only -rzv"
#settings="--stats --progress --delete-during --max-delete=10 --size-only -rzv"
#dryrun=--dry-run
dryrun=

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then echo "Already running"; exit; fi

#running=`ps auxww | grep -v .git | grep /usr/bin/rsync`
clear
echo "####################################################################"
echo "#                 Local Drobo Media Sync Script                    #"
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
	   echo "This script not already running, will continue in 5 seconds"
	   sleep 1
	   echo "                                                  4 seconds"
	   sleep 1
	   echo "                                                  3 seconds"
	   sleep 1
	   echo "                                                  2 seconds"
	   sleep 1
	   echo "                                                  1 second "
	   sleep 1
fi

date >> $log

clear
echo "####################################################################"
echo "#                 Local Drobo Media Sync Script                    #"
echo "####################################################################"
echo " "
echo " "
echo "Starting local file transfer from Mr. Universe to Lenore"
date
echo " "
echo "Drobo Local Sync"
echo "Drobo Local Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings $MrU $Lenore $dryrun
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings2 $MrU2 $Lenore2 $dryrun
#echo "Drobo Local Sync Disabled"
date >> $log
echo "Drobo Local Sync Finished"
date
echo " "
echo "Drobo Local Sync Finished" >> $log
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
