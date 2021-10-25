#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`
remotehome=`cat $HOME/Scripts/.dontsync/bysh_home`

local_temp_dir=/mnt/MrU/Working/zRsyncing
local_dir_tv=/mnt/MrU/Working/Rsynced/
local_dir_movies=/mnt/MrU/Working/Movies/
log=$HOME/Scripts/logs/log.byte
remote_dir_tv=$remotehome/torrents/completed/
remote_dir_movies=$remotehome/torrents/movies/

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
echo "Starting file transfer from Byte to Mr. Universe "
date
echo " "

echo "TV Files to transfer: "
ssh $dst ls -R torrents/completed | grep -e .mkv -e .mp4
echo " "
echo "Movie Files to transfer: "
ssh $dst ls -R torrents/movies | grep -e .mkv -e .mp4
echo " "
echo "TV Sync"
echo " "
echo "TV Sync" >> $log
/usr/bin/rsync --remove-source-files --prune-empty-dirs --temp-dir=$local_temp_dir --log-file=$log -rzvIPe ssh --stats $dst:$remote_dir_tv $local_dir_tv 

date >> $log

ssh $dst touch $remote_dir_tv/anchor.txt
ssh $dst find $remote_dir_tv -type d -delete

echo "TV Sync Finished"
echo " "
echo "TV Sync Finished" >> $log
date

date >> $log
echo "Movie Sync"
echo " "
echo "Files to transfer: "
ssh $dst ls -R torrents/movies | grep -e .mkv -e .mp4
echo " "
echo "Movie Sync" >> $log
/usr/bin/rsync --remove-source-files --prune-empty-dirs --temp-dir=$local_temp_dir --log-file=$log -rzvIPe ssh --stats $dst:$remote_dir_movies $local_dir_movies 

date >> $log
date
echo "Movie Sync Finished"
echo "Movie Sync Finished" >> $log

ssh $dst touch $remote_dir_movies/anchor.txt
ssh $dst find $remote_dir_movies -type d -delete

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

exit 0
