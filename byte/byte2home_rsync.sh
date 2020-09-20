#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`
remotehome=`cat $HOME/Scripts/.dontsync/bysh_home`

local_temp_dir=/mnt/MrU/Working/zRsyncing
local_dir_tv=/mnt/MrU/Working/Sickrage/
local_dir_movies=/mnt/MrU/Working/Movies/
log=$HOME/Scripts/logs/log.byte2home
remote_dir_tv=$remotehome/torrents/completed/
remote_dir_movies=$remotehome/torrents/movies/

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
	   echo "RSYNC is runnning, stopping..."
           /usr/bin/killall rsync &>/dev/null
	   sleep 1
	   echo "                   30 seconds"
	   sleep 14
           /usr/bin/killall rsync &>/dev/null
	   echo "                   14 seconds"
	   sleep 1
	   echo "                   13 seconds"
	   sleep 1
	   echo "                   12 seconds"
	   sleep 1
	   echo "                   11 seconds"
	   sleep 1
	   echo "                   10 seconds"
	   sleep 1
	   echo "                   09 seconds"
	   sleep 1
	   echo "                   08 seconds"
	   sleep 1
	   echo "                   07 seconds"
	   sleep 1
	   echo "                   06 seconds"
	   sleep 1
	   echo "                   05 seconds"
	   sleep 1
	   echo "                   04 seconds"
	   sleep 1
	   echo "                   03 seconds"
	   sleep 1
	   echo "                   02 seconds"
	   sleep 1
	   echo "                   01 seconds"
	   sleep 1
           /usr/bin/killall rsync &>/dev/null
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

#echo "TV Sync"
#echo " "
echo "TV Files to transfer: "
ssh $dst ls -R torrents/completed | grep -e .mkv -e .mp4
echo " "
echo "Movie Files to transfer: "
ssh $dst ls -R torrents/movies | grep -e .mkv -e .mp4
echo " "
echo "TV Sync" >> $log
#/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIPe ssh  $dst:$remote_dir_tv $local_dir_tv 
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
#/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIPe ssh $dst:$remote_dir_movies $local_dir_movies 
/usr/bin/rsync --remove-source-files --prune-empty-dirs --temp-dir=$local_temp_dir --log-file=$log -rzvIPe ssh --stats $dst:$remote_dir_movies $local_dir_movies 

date >> $log
echo "Movie Sync Finished"
echo "Movie Sync Finished" >> $log

ssh $dst touch $remote_dir_movies/anchor.txt
ssh $dst find $remote_dir_movies -type d -delete

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

exit 0
