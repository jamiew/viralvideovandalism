#!/bin/bash

watermark=""
input="$1"

if [ -z $input ]; then
  echo "No input file"
  exit 1
fi

filename="${input%.*}"
ext="${input#*.}"

# rip video from youtube
#youtube-dl "$input" -o "$file"
#mediainfo "$file"

# pick the right katsutag based on input file size dimensions
# 1080p, 720p, 480p best-fit
# TODO
quality="1080p"
tag="katsu_watermarktag_${quality}.mov"

# overlay watermark onto the video
output="${filename}_tagged.${ext}"
ffmpeg -y -i $input -vf "movie=$tag, scale=720:540 [ovl]; [in][ovl] overlay" "$output"
mediainfo "$output"

# upload back to youtube
# TODO

# our work here is done
