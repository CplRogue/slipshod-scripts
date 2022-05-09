#!/bin/bash

local_temp_dir=/mnt/Lenore/Working
local_dir=/mnt/Lenore/Videos/
local_dir_music=/mnt/Lenore/Music/

log=$HOME/Scripts/logs/log.rsyncpull

message_anime=$HOME/Scripts/rsync_pull/tmp/anime.msg
message_kids=$HOME/Scripts/rsync_pull/tmp/kids.msg
message_mature=$HOME/Scripts/rsync_pull/tmp/mature.msg
message_tv=$HOME/Scripts/rsync_pull/tmp/tv.msg
message_movies=$HOME/Scripts/rsync_pull/tmp/movies.msg
message_music=$HOME/Scripts/rsync_pull/tmp/music.msg

pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

remote_dir_anime=/mnt/MrU/Videos/Anime
remote_dir_kids=/mnt/MrU/Videos/Kids
remote_dir_mature=/mnt/MrU/Videos/Mature
remote_dir_tv=/mnt/MrU/Videos/Series
remote_dir_movies=/mnt/MrU/Videos/Movies
remote_dir_music=/mnt/MrU/Music

#settings="--stats --progress --delete-during --size-only -rzv"
settings="--stats --progress --delete-during --max-delete=10 --size-only -rzv"
settings2="--stats --progress --size-only -rzv"
#dryrun=--dry-run
dryrun2=--dry-run
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
echo "TV Sync Finished" > $message_tv
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_tv
tv_exists=$(tail -n 3 $message_tv | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$tv_exists" ] 
	then echo "Empty TV Message"
else 
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_tv`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi

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
echo "Mature Sync Finished" > $message_mature
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_mature
mature_exists=$(tail -n 3 $message_mature | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$mature_exists" ] 
	then echo "Empty Mature Message"
else 
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_mature`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi

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
echo "Kids Sync Finished" > $message_kids
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_kids
kids_exists=$(tail -n 3 $message_kids | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$kids_exists" ] 
	then echo "Empty Kids Message"
else 
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_kids`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi

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
echo "Anime Sync Finished" > $message_anime
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_anime
anime_exists=$(tail -n 3 $message_anime | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$anime_exists" ] 
	then echo "Empty Anime Message"
else 
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_anime`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi

echo "Movie Sync"
echo "Movie Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_movies $local_dir $dryrun
#echo "Movie Sync Disabled"
date >> $log
echo "Movie Sync Finished"
date
echo " "
echo "Movie Sync Finished" >> $log
date >> $log
echo "Movie Sync Finished" > $message_movies
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_movies
movies_exists=$(tail -n 3 $message_movies | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$movies_exists" ] 
	then echo "Empty Movies Message"
else 
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_movies`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi

echo "Music Sync"
echo "Music Sync" >> $log
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log $settings2 -e 'ssh -p 4432' mal@home.thewares.net:$remote_dir_music $local_dir_music $dryrun2
#echo "Music Sync Disabled"
date >> $log
echo "Music Sync Finished"
date
echo " "
echo "Music Sync Finished" >> $log
date >> $log
echo "Music Sync Finished" > $message_music
tail -n 20 $log | grep -B 17 Finished | grep Number | awk '{$1=$2=$3=""; print $0}' >> $message_music
music_exists=$(tail -n 3 $message_music | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$music_exists" ] 
	then echo "Empty Music Message"
else 
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_music`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi


echo "done" >> $log
echo "Finished > Exiting" >> $log
date >> $log
echo "" >> $log


exit 0
