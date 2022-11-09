#!/bin/bash

# Standard settings I use for converting videos to gif. Not perfect, so might tweak parameters
function vid2gif() {
    vid=$1
    gif=$2

    ffmpeg -i $vid -lavfi "mpdecimate,scale=800:-1" -loop 0 $gif
}

# I always forget the arguments to this command (arp). Raspberry Pi always have a mac address starting with this pattern, so just have an alias for it
# TODO: works for Pi4? Only tested with first-gen
alias findRpi='arp -na | grep -i b8:27:eb'
