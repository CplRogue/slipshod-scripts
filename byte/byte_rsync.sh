#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`

local_dir_tv=/mnt/MrU/Working/Seeding/Sickrage/
local_dir_movies=/mnt/MrU/Working/Seeding/Movies/
log=$HOME/Scripts/logs/log.byte
remote_dir_tv=$HOME/torrents/completed/
remote_dir_movies=$HOME/torrents/movies/

/usr/bin/killall rsync
sleep 30

date >> $log
echo "TV Sync" >> $log
/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIP $dst:$remote_dir_tv $local_dir_tv 

date >> $log

ssh $dst touch $remote_dir_tv/anchor.txt
ssh $dst find $remote_dir_tv -type d -delete

date >> $log
echo "Movie Sync" >> $log
/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIP $dst:$remote_dir_movies $local_dir_movies 

date >> $log

#ssh $dst touch $remote_dir_movies/anchor.txt
#ssh $dst find $remote_dir_movies -type d -delete

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

