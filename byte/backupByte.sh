#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`
remotehome=`cat $HOME/Scripts/.dontsync/bysh_home`

local_temp_dir=/mnt/Media/Working/zRsyncing
local_dir=/mnt/Media/Backups/Plex/Byte
log=$HOME/Scripts/logs/log.byte
remote_dir=$remotehome/backups/

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

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
	   echo "RSYNC is already runnning"
           echo " "
           sleep 1
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
echo "#                           Backup Sync Script                      #"
echo "####################################################################"
echo " "
echo " "
echo "Starting file transfer from Byte to Mr. Universe "
date
echo " "

echo "Backup Sync" >> $log
echo "Backup Sync"
echo " "
#/usr/bin/rsync --remove-source-files --prune-empty-dirs --temp-dir=$local_temp_dir --log-file=$log -rzvIPe ssh --stats $dst:$remote_dir $local_dir 
/usr/bin/rsync --temp-dir=$local_temp_dir --log-file=$log -rvP --size-only --stats $dst:$remote_dir $local_dir 

date >> $log

echo "Backup Sync Finished"
echo " "
echo "Backup Sync Finished" >> $log
date

exit 0
