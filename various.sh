#!/bin/bash

# Standard settings I use for converting videos to gif. Not perfect, so might tweak parameters
function vid2gif() {
    vid=$1
    gif=$2

    ffmpeg -i $vid -lavfi "mpdecimate,scale=800:-1" -loop 0 $gif
}
