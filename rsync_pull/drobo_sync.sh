#!/bin/bash

local_temp_dir=/mnt/Lenore/Working
local_dir=/mnt/Lenore/Videos/

log=$HOME/Scripts/logs/log.rsyncpull
message=$HOME/Scripts/rsync_pull/tmp/last.msg
pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

remote_dir_anime=/mnt/MrU/Videos/Anime
remote_dir_kids=/mnt/MrU/Videos/Kids
remote_dir_mature=/mnt/MrU/Videos/Mature
remote_dir_tv=/mnt/MrU/Videos/Series
remote_dir_movies=/mnt/MrU/Videos/Movies

#settings="--stats --progress --delete-during --size-only -rzv"
settings="--stats --progress --delete-during --max-delete=10 --size-only -rzv"
#dryrun=--dry-run
dryrun=

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then echo "Already running"; exit; fi

running=`ps auxww | grep -v .git | grep /usr/bin/rsync`
clear
echo "####################################################################"
echo "#                           Media Sync Script                      #"
echo "####################################################################"
echo " "
echo " "
echo " "
echo " "
echo "Checking to see if RSYNC is already running"
echo " "
sleep 1

if [[ "$running" == *"pierus"* ]]
   then
	   echo "RSYNC is already runnning, exiting..."
           echo " "
           sleep 1
	   exit 0
   else	   
	   echo "RSYNC not running, will continue in 5 seconds"
	   sleep 1
	   echo "                                    4 seconds"
	   sleep 1
	   echo "                                    3 seconds"
	   sleep 1
	   echo "                                    2 seconds"
	   sleep 1
	   echo "                                    1 second "
	   sleep 1
fi

date >> $log

clear
echo "####################################################################"
echo "#                           Media Sync Script                      #"
echo "####################################################################"
echo " "
echo " "
echo "Starting file transfer from Mr. Universe to Lenore"
date
echo " "
echo "TV Sync"
echo "TV Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_tv $local_dir $dryrun
#echo "TV Sync Disabled"
date >> $log
echo "TV Sync Finished"
date
echo " "
echo "TV Sync Finished" >> $log
date >> $log
echo "TV Sync Finished" > $message
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

echo "Mature Sync"
echo "Mature Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_mature $local_dir $dryrun
#echo "Mature Sync Disabled"
date >> $log
echo "Mature Sync Finished"
date
echo " "
echo "Mature Sync Finished" >> $log
date >> $log
echo "Mature Sync Finished" > $message
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

echo "Kids Sync"
echo "Kids Sync" >> $log
#/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_kids $local_dir $dryrun
echo "Kids Sync Disabled"
date >> $log
echo "Kids Sync Finished"
date
echo " "
echo "Kids Sync Finished" >> $log
date >> $log
echo "Kids Sync Finished" > $message
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

echo "Anime Sync"
echo "Anime Sync" >> $log
#/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_anime $local_dir $dryrun
echo "Anime Sync Disabled"
date >> $log
echo "Anime Sync Finished"
date
echo " "
echo "Anime Sync Finished" >> $log
date >> $log
echo "Anime Sync Finished" > $message
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

echo "Movie Sync"
echo "Movie Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_movie $local_dir $dryrun
#echo "Movie Sync Disabled"
date >> $log
echo "Movie Sync Finished"
date
echo " "
echo "Movie Sync Finished" >> $log
date >> $log
echo "Movie Sync Finished" > $message
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

echo "done" >> $log
echo "Finished > Exiting" >> $log
date >> $log
echo "" >> $log

exit 0
