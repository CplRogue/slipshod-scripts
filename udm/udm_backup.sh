#!/usr/bin/bash

##################################################
# set vars
##################################################
backup_location=/mnt/MrU/Backups/GeekyTiki/UDM
backup_filename=Unifi-Backup
hostname=$(hostname -f)
datestamp=$(date "+%Y%m%d")
backup_filename=$backup_filename-$datestamp
backup_age=8 # 7 Days
success=$HOME/Scripts/udm/temp/exists.txt
status=$HOME/Scripts/udm/temp/status.txt
message=$HOME/Scripts/udm/temp/message.txt
pushover_app=$HOME/Scripts/.dontsync/pushover_app_lf
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr
udm_user=root # Replace with your UDM/UDMP username (e.g. root)
udm_address=10.0.1.1 # Replace with your UDM/UDMP IP or hostname

##################################################
# Start Script
##################################################


#Show Description
cat <<EOF

        -----------------------------------------------------------------
        Unifi Config Backup
        Hostname: "$hostname"
        Timestamp: "$datestamp"
        Backup filename: "$backup_filename"
        Backup target: "$backup_location"
        -----------------------------------------------------------------

EOF

# Copy the Files
echo "Retrieving Backups from UDM..."
sshpass -p "pants party mower grill" scp -r $udm_user@$udm_address:/mnt/data/unifi-os/unifi/data/backup/autobackup/* $backup_location/
#spawn scp -r $udm_user@$udm_address:/mnt/data/unifi-os/unifi/data/backup/autobackup/* $backup_location/
#expect "assword:"
#send "pants party mower grill\r"
#interact

# Compress
#echo "Creating archive $backup_location/$backup_filename.zip..."
##zip -r $backup_location/$backup_filename.zip  $backup_location -j -x "*.zip"
#rm -f $backup_location/*.unf
#rm -f $backup_location/*.json

# Delete backup archives older than target days
#echo "Cleaning up archives..."
#cd $backup_location
#ls $backup_location/*.zip -tp | grep -v '/$' | tail -n +$backup_age | xargs -d '\n' -r rm --

#unzip -l $backup_location/$backup_filename.zip | grep $datestamp 
#unzip -l $backup_location/$backup_filename.zip | grep $datestamp > $status

#cat $status | grep Archive > $success

#if [ -s $success ] ; then

#echo "$success has data."
#echo "Dream Machine Pro Config Backup
#Backup filename: 
# "$backup_filename.zip"
#Backup target: 
# "$backup_location"" > $message

#curl -s \
#  --form-string "token=`cat $pushover_app`" \
#  --form-string "user=`cat $pushover_usr`" \
#  --form-string "priority=0" \
#  --form-string "message=`cat $message`" \
#  https://api.pushover.net/1/messages.json

#else
#echo "$success is empty."
#fi ;
echo "Script done"

exit
