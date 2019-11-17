#!/bin/bash

#
# https://github.com/ehendrix23/tesla_dashcam
#

oldfile=/mnt/MrU/Working/TeslaCam/Completed/SavedClips.mp4

#/home/mal/.pyenv/shims/tesla_dashcam -h
#/home/mal/.pyenv/shims/tesla_dashcam --check_for_update

/home/mal/.pyenv/shims/tesla_dashcam --no-check_for_update --no-notification --motion_only --layout DIAMOND --mirror --skip_existing --temp_dir /home/mal/Scripts/dashcam/tmp --output /mnt/MrU/Working/TeslaCam/Completed /mnt/MrU/Working/TeslaCam/New

mv $oldfile /mnt/MrU/Videos/TeslaCam/SavedClips/${oldfile}_$(date +%F-%T).mp4

#Sorting Movies
BASE=/mnt/MrU/Working/TeslaCam/Completed
PLEX=/mnt/MrU/Videos/TeslaCam

echo " "
echo "Base Directory:"
echo $BASE
echo "Plex Directory:"
echo $PLEX
echo " "

for file in $BASE/*.mp4 ; do
    mfile=$( echo "$file" | cut -c 37-79 )
    yfol=$( echo "$file" | cut -c 37-40 )
    mfol=$( echo "$file" | cut -c 37-43 )
    dfol=$( echo "$file" | cut -c 37-46 )
    mkdir -p $PLEX/${yfol}/${mfol}/${dfol}
    mv --verbose $BASE/"$mfile" $PLEX/${yfol}/${mfol}/${dfol}/"$mfile"
done

echo " "
echo "Filename:"
echo $mfile
echo "Year:"
echo $yfol
echo "Month:"
echo $mfol
echo "Day:"
echo $dfol


mkdir -p /mnt/MrU/Working/TeslaCam/Old/${yfol}/${mfol}
mv /mnt/MrU/Working/TeslaCam/New/* /mnt/MrU/Working/TeslaCam/Old/${yfol}/${mfol}
rmdir /mnt/MrU/Videos/TeslaCam/*.mp/*.mp4/*.mp4
rmdir /mnt/MrU/Videos/TeslaCam/*.mp/*.mp4
rmdir /mnt/MrU/Videos/TeslaCam/*.mp

exit
