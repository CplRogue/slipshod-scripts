#!/bin/bash

Primary_Drobo=/mnt/MrU/Videos/Mature/
Secondary_Drobo=/mnt/Lenore/Videos/Mature/
log=$HOME/Scripts/logs/log.rsync-drobo

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
#/usr/bin/rsync --dry-run --log-file=$log -rzvIPe --stats $Primary_Drobo $Secondary_Drobo 
#/usr/bin/rsync --log-file=$log -rzvIPe --stats $Primary_Drobo $Secondary_Drobo 
#/usr/bin/rsync --log-file=$log -rzvIP --stats $Primary_Drobo $Secondary_Drobo 
#/usr/bin/rsync --log-file=$log -rvIP --stats $Primary_Drobo $Secondary_Drobo 
/usr/bin/rsync --log-file=$log -rvP --size-only --stats $Primary_Drobo $Secondary_Drobo 

date >> $log

echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

exit 0
