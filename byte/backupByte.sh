#!/bin/bash

dst=`cat $HOME/Scripts/.dontsync/bysh_acct`
remotehome=`cat $HOME/Scripts/.dontsync/bysh_home`

local_dir=/mnt/MrU/Backups/JottaCloud_Backups/Byte/
log=$HOME/Scripts/logs/log.backupByte
remote_dir=$remotehome/backups/

date >> $log
echo "Backup Sync" >> $log
/usr/bin/rsync --prune-empty-dirs --log-file=$log -rizcvIPe ssh  $dst:$remote_dir $local_dir 
#/usr/bin/rsync --remove-source-files --prune-empty-dirs --log-file=$log -rizcvIPe ssh  $dst:$remote_dir $local_dir 

date >> $log
echo "done" >> $log
echo "Finished > Exiting" >> $log
echo "" >> $log

