#!/bin/bash
find /mnt/Media/Videos/Series -type f -printf '%s %p\n' | sort -nr | grep -v "The Grand Tour" | grep -v "Game of Thrones" | grep -v "Band of Brothers" | grep -v "Blue Planet II" | grep -v "eXtraction" | head -10 > /home/mal/Scripts/large_files/manual_run.txt
