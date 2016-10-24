#!/bin/bash

LOC=10.0.1.96
#PARMS='--verbose --recursive --perms --size-only --compress --progress --human-readable'
PARMS='--verbose --recursive --delete-during --perms --size-only --compress --progress --human-readable'
#PARMS='--verbose --recursive --delete-during --perms --size-only --compress --progress --human-readable --dry-run'
#-v, --verbose               increase verbosity
#-r, --recursive             recurse into directories
#--delete-during             receiver deletes during the transfer
#-u, --update                skip files that are newer on the receiver
#-p, --perms                 preserve permissions
#--size-only                 skip files that match in size
#-z, --compress              compress file data during the transfer
#-h, --human-readable        output numbers in a human-readable format
#--progress                  show progress during transfer
#-n, --dry-run               perform a trial run with no changes made
LMT='--bwlimit=500'
DEST0=LenoreMovies
DEST1=LenoreTV

#curl -s \
#  -F "message=Rsync $LMT" \
#  -F "priority=-1" \
#   https://api.pushover.net/1/messages.json

/usr/bin/rsync $PARMS $LMT /mnt/MrU/Videos/Movies/ MrUniverse@$LOC::LenoreMovies >> ~/log_rsync.log
/usr/bin/rsync $PARMS $LMT /mnt/MrU/Videos/Series/ mal@$LOC::LenoreTV >> ~/log_rsync.log
