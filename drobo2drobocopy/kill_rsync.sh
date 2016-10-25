#!/bin/bash

if [[ -n $(pidof -xo $$ rsync) ]]; then
    echo ""
    echo Rsync is up and running!
    echo ""
    /usr/bin/pkill rsync
    sleep 2
    /usr/bin/pkill rsync
    sleep 2
    /usr/bin/pkill rsync
    sleep 2
    /usr/bin/pkill rsync
    sleep 2
    echo Killed Rsync 
    echo ""
fi


if [[ -n $(pidof -xo $$ rsync) ]]; then
    echo ""
    echo Rsync is still up and running!
    exit 1
else
    echo ""
    echo No Rsync running
#    exec "$HOME/Scripts/drobocopy/dcopy_fast_lenore.sh" &
    echo ""
#    echo Started Rsync Fast
    echo ""
fi
