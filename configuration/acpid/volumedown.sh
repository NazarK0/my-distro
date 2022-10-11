#!/bin/sh

amixer set Capture 5%%-

volume=$(awk -F"[][]" '/Left:/ { print $2 }' < amixer sget Master)
/bin/su -c "dunstify -u 'normal' -r 200 -h string:x-dunst-stack-tag:$volume 'Гучність: $volume'" $(id -u -n 1000)