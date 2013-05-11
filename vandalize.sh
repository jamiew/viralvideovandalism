#!/bin/bash

watermark=""
input="$1"

if [ -z $input ]; then
  echo "No input file"
  exit 1
fi

# rip video from youtube
file="output"
youtube-dl "$input" -o "$file"

# make sure it's ok
mediainfo "$file"

# add watermark to the video
output="${file}_tagged.mov"
ffmpeg -i $file -vf "movie=KATSUskull_WaterMark.mov [ovl]; [in][ovl] overlay" "$output"
mediainfo "$output"

# upload back to youtube
# TODO

# our work here is done
