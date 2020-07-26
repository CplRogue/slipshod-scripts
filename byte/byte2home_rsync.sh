#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`
remotehome=`cat $HOME/Scripts/.dontsync/bysh_home`

local_dir_tv=/mnt/MrU/Working/Sickrage/
local_dir_movies=/mnt/MrU/Working/Movies/
log=$HOME/Scripts/logs/log.byte2home
remote_dir_tv=$remotehome/torrents/completed/
remote_dir_movies=$remotehome/torrents/movies/

clear
echo "####################################################################"
echo "#                           Media Sync Script                      #"
echo "####################################################################"
echo " "
echo " "
echo " "
echo " "
echo "Pausing for 30 seconds to check that rsync is not already running"
/usr/bin/killall rsync &>/dev/null
sleep 5
echo "            25 seconds"
sleep 5
echo "            20 seconds"
sleep 5
echo "            15 seconds"
/usr/bin/killall rsync &>/dev/null
sleep 5
echo "            10 seconds"
sleep 5
echo "             5 seconds"
sleep 5
echo "             0 seconds"
sleep 1 

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

echo "TV Sync"
echo " "
echo "Files to transfer: "
ssh $dst ls -R torrents/completed | grep -e .mkv -e .mp4
echo " "
echo "TV Sync" >> $log
/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIPe ssh  $dst:$remote_dir_tv $local_dir_tv 

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
/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIPe ssh $dst:$remote_dir_movies $local_dir_movies 

date >> $log
echo "Movie Sync Finished"
echo "Movie Sync Finished" >> $log

ssh $dst touch $remote_dir_movies/anchor.txt
ssh $dst find $remote_dir_movies -type d -delete

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log
