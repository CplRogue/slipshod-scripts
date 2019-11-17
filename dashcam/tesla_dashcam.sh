#!/bin/bash

oldfile=/Volumes/Media/Videos/TeslaCam/SavedClips/SavedClips.mp4

#/Applications/tesla_dashcam -h
#/Applications/tesla_dashcam --check_for_update

#/Applications/tesla_dashcam --no-check_for_update --layout WIDESCREEN --merge --output /Volumes/Media/Videos/TeslaCam/SavedClips /Volumes/Media/Working/TeslaCam/New
/Applications/tesla_dashcam --no-check_for_update --layout DIAMOND --merge --output /Volumes/Media/Videos/TeslaCam/SavedClips /Volumes/Media/Working/TeslaCam/New

mv $oldfile ${oldfile}_$(date +%F-%T).mp4

mv /Volumes/Media/Working/TeslaCam/New/* /Volumes/Media/Working/TeslaCam/Old/SavedClips/
