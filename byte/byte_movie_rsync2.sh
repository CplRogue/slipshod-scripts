#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct2`

local_dir_movies=/mnt/MrU/Videos/Movies/
log=$HOME/Scripts/logs/log.byte_movies
remote_dir_movies=$HOME/media/Movies/

date >> $log
echo "Movie Sync" >> $log
/usr/bin/rsync --log-file=$log -rizcvIP $local_dir_movies $dst:$remote_dir_movies

date >> $log

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

