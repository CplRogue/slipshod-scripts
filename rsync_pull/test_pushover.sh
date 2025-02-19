#!/bin/bash

message_anime=$HOME/Scripts/rsync_pull/tmp/anime.msg
message_kids=$HOME/Scripts/rsync_pull/tmp/kids.msg
message_mature=$HOME/Scripts/rsync_pull/tmp/mature.msg
message_tv=$HOME/Scripts/rsync_pull/tmp/tv.msg
message_movies=$HOME/Scripts/rsync_pull/tmp/movies.msg
message_music=$HOME/Scripts/rsync_pull/tmp/music.msg

pushover_app=$HOME/Scripts/.dontsync/pushover_app_drobo
pushover_usr=$HOME/Scripts/.dontsync/pushover_usr

echo "start"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=Starting" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

echo " "
echo "Test TV Sync Message"
echo "Last 3 lines of tv.msg:"
cat $message_tv
echo "Remove all text and zeros from tv.msg:"
#tail -n 3 $message_tv | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}'
tv_exists=$(tail -n 3 $message_tv | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$tv_exists" ] 
	then echo "TV Message zero files"
else 
	echo "Send above to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_tv`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
echo " "

echo "Test Mature Sync Message"
echo "mature.msg containts:"
cat $message_mature
echo "Remove all text and zeros from mature.msg:"
#tail -n 3 $message_mature | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}'
mature_exists=$(tail -n 3 $message_mature | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$mature_exists" ] 
	then echo "Mature Message zero files"
else 
	echo "Send above to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_mature`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
echo " "

echo "Test Kids Sync Message"
echo "kids.msg containts:"
cat $message_kids
echo "Remove all text and zeros from kids.msg:"
#tail -n 3 $message_kids | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}'
kids_exists=$(tail -n 3 $message_kids | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$kids_exists" ] 
	then echo "Kids Message zero files"
else 
	echo "Send above to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_kids`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
echo " "

echo "Test Anime Sync Message"
echo "anime.msg containts:"
cat $message_anime
echo "Remove all text and zeros from anime.msg:"
#tail -n 3 $message_anime | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}'
anime_exists=$(tail -n 3 $message_anime | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$anime_exists" ] 
	then echo "Anime Message zero files"
else 
	echo "Send above to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_anime`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
echo " "

echo "Test Movies Sync Message"
echo "movies.msg containts:"
cat $message_movies
echo "Remove all text and zeros from movies.msg:"
#tail -n 3 $message_movies | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}'
movies_exists=$(tail -n 3 $message_movies | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$movies_exists" ] 
	then echo "Movies Message zero files"
else 
	echo "Send above to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_movies`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
echo " "

echo "Test Music Sync Message"
echo "music.msg containts:"
cat $message_music
echo "Remove all text and zeros from music.msg:"
#tail -n 3 $message_music | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}'
music_exists=$(tail -n 3 $message_music | sed -r 's/[a-zA-Z0:,()]//g' | awk '{if(NF>0) {print $0}}')
if [ -z "$music_exists" ] 
	then echo "Music Message zero files"
else 
	echo "Send above to Pushover"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=`cat $message_music`" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1
fi
echo " "

echo "done"
curl -s \
  --form-string "token=`cat $pushover_app`" \
  --form-string "user=`cat $pushover_usr`" \
  --form-string "priority=-2" \
  --form-string "message=Done" \
  https://api.pushover.net/1/messages.json > /dev/null 2>&1

exit 0
