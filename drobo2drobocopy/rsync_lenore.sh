#!/bin/bash

LOC=10.0.1.95
PARMS='-vzrup --progress -h'
#LMT='--bwlimit=250'
#LMT='--bwlimit=500'
LMT='--bwlimit=5000'
DEST0=LenoreMovies
DEST1=LenoreTV

curl -s \
  -F "message=Rsync $LMT" \
  -F "priority=-1" \
   https://api.pushover.net/1/messages.json

/usr/bin/rsync $PARMS $LMT /mnt/MrU/Videos/Movies/ mal@10.0.1.95::LenoreMovies
/usr/bin/rsync $PARMS $LMT /mnt/MrU/Videos/Series/ mal@10.0.1.95::LenoreTV
