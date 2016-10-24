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
    exec "/home/mal/Scripts/drobocopy/dcopy_slow_lenore.sh" &
    echo ""
    echo Started Rsync Slow
    echo ""
fi
