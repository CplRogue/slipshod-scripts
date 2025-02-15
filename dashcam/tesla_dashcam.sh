#!/bin/bash

#
# https://github.com/ehendrix23/tesla_dashcam
#

cam=/usr/local/bin/tesla_dashcam
settings='--no-check_for_update --no-notification --motion_only --layout DIAMOND --mirror --skip_existing --monitor_trigger event.json'

year=`date +"%Y"`
month=`date +"%Y-%m"`
day=`date +"%Y-%m-%d"`

tempdir=/home/mal/Scripts/dashcam/tmp
input=/mnt/Media/Working/TeslaCam/New
output=/mnt/Media/Videos/TeslaCam
old=/mnt/Media/Working/TeslaCam/Old

{
#if  [ ! -f $input/*mp4 ]; then
#if  [ ! -d $input/SentryClips ]; then
if  [ ! -d $input/SentryClips ]; then
    echo " "
    echo "SentryClips not found..."
	if  [ ! -d $input/SavedClips ]; then
    	echo "SavedClips not found, exiting"
        echo " "
        exit 0
	fi
    echo "SavedClips found, continuing..."
    echo " "
    fi
}


#Make today's directory
mkdir -p $output/$year/$month/$day
mkdir -p $old/$year/$month/$day

#Check for updates
$cam --check_for_update

#Make new dashcam vidoes
$cam $settings --temp_dir $tempdir --output $output/$year/$month/$day $input

#Clean up
rm $tempdir/*.mp4
cp -R $input/SavedClips $old/$year/$month/$day/
cp -R $input/SentryClips $old/$year/$month/$day/
rm -rf $input/SavedClips
rm -rf $input/SentryClips

exit
