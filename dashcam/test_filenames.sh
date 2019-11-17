#!/bin/bash  
BASE=/mnt/MrU/Working/TeslaCam/Test/Files
PLEX=/mnt/MrU/Working/TeslaCam/Test/Complete

echo " "
echo "Base Directory:"
echo $BASE
echo "Plex Directory:"
echo $PLEX

for file in $BASE/*.mp4 ; do
    mfile=$( echo "$file" | cut -c 38-80 )
    yfol=$( echo "$file" | cut -c 38-41 )  
    mfol=$( echo "$file" | cut -c 38-44 )  
    dfol=$( echo "$file" | cut -c 38-47 )  
    mkdir -p $PLEX/${yfol}/${mfol}/${dfol}  
    mv --verbose $BASE/"$mfile" $PLEX/${yfol}/${mfol}/${dfol}/"$mfile"
done

echo " "
echo "Filename:"
echo $mfile
echo $yfol
echo $mfol
echo $dfol



#/home/mal/.pyenv/shims/tesla_dashcam --no-check_for_update --no-notification --motion_only --layout DIAMOND --mirror --skip_existing --temp_dir /home/mal/Scripts/dashcam/tmp --output $SAVEPATH/$YESTERDAY /mnt/MrU/Working/TeslaCam/New
