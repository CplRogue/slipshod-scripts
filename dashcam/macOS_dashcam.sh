#!/bin/bash

#
# https://github.com/ehendrix23/tesla_dashcam
#

ffmpeg=/Users/mal/Scripts/dashcam/ffmpeg

#settings='--no-check_for_update --no-notification --motion_only --layout DIAMOND --mirror --skip_existing'
settings='--no-check_for_update --no-notification --motion_only --layout DIAMOND --mirror --skip_existing --monitor_trigger event.json'

year=`date +"%Y"`
month=`date +"%Y-%m"`
day=`date +"%Y-%m-%d"`

tempdir=/Users/mal/Scripts/dashcam/tmp
output=/Volumes/Media/Videos/TeslaCam
input=/Volumes/Media/Working/TeslaCam/New
old=/Volumes/Media/Working/TeslaCam/Old

#Make today's directory
mkdir -p $output/$year/$month/$day
mkdir -p $old/$year/$month/$day

#Check for updates
/Applications/tesla_dashcam --check_for_update

#Make new dashcam vidoes
#/Applications/tesla_dashcam $settings --ffmpeg $ffmpeg --temp_dir $tempdir --output $output/$year/$month/$day /Volumes/Media/Working/TeslaCam/New
/Applications/tesla_dashcam $settings --ffmpeg $ffmpeg --temp_dir $tempdir --output $output/$year/$month/$day $input

#Clean up
rm $tempdir/*.mp4
cp -R $input/SavedClips $old/$year/$month/$day/
cp -R $input/SentryClips $old/$year/$month/$day/
rm -rf $input/SavedClips
rm -rf $input/SentryClips

exit
