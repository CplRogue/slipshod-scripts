#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`
remotehome=`cat $HOME/Scripts/.dontsync/bysh_home`

local_dir_movies=/mnt/MrU/Working/Movies/
log=$HOME/Scripts/logs/log.byte2hold
remote_dir_movies=$remotehome/torrents/hold/

/usr/bin/killall rsync
sleep 15
/usr/bin/killall rsync
sleep 15

date >> $log

echo "Hold Sync" >> $log
#/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIPe ssh $dst:$remote_dir_movies $local_dir_movies 
/usr/bin/rsync --log-file=$log -rizcvIPe ssh $dst:$remote_dir_movies $local_dir_movies 


date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

