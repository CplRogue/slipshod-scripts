#!/bin/bash

Primary_Drobo=/mnt/MrU/
Secondary_Drobo=/mnt/Lenore/
log=$HOME/Scripts/logs/log.rsync-drobo
message=$HOME/Scripts/drobo/tmp/rsynclast.msg
#size=$HOME/Scripts/drobo/tmp/rsynclast.size
mrusize=$HOME/Scripts/size/tmp/last.size
pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

#Dry run
#$dry=--dry-run
$dry=-n
#$dry=

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

running=`ps auxww | grep -v .git | grep /usr/bin/rsync`
clear
echo "####################################################################"
echo "#                           Drobo Sync Script                      #"
echo "####################################################################"
echo " "
echo " "
echo " "
echo " "
echo "Checking to see if RSYNC is already running"
echo " "
sleep 1

if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then
	echo "This script is already running with PID `pidof -x $(basename $0) -o %PPID`"
	echo " "
	exit
fi

date >> $log

clear
echo "####################################################################"
echo "#                           Drobo Sync Script                      #"
echo "####################################################################"
echo " "
echo " "
date
echo " "

#/usr/bin/rsync --remove-source-files --prune-empty-dirs --temp-dir=$local_temp_dir --log-file=$log -rzvIPe ssh --stats $dst:$remote_dir_tv $local_dir_tv 

#Dry Run
/usr/bin/rsync --log-file=$log -n -rvP --size-only --stats --exclude=.DS_Store $Primary_Drobo $Secondary_Drobo 
#For Real
#/usr/bin/rsync --log-file=$log -rvP --size-only --stats --exclude=.DS_Store $Primary_Drobo $Secondary_Drobo 

date >> $log

echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

exit 0
