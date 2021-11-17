#!/usr/bin/env bash
cat ~/.config/mpd/playlists/Favorite.m3u | grep -v '#' | \
while read i; do cp "${i}" $1 ; done 
