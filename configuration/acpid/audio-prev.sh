#!/bin/sh

user=$(id -u -n 1000)

/bin/su -c "playerctl previous" $user

sleep 2
message=$(/bin/su -c "playerctl metadata --format '{{artist}}-{{title}}'" $user)
/bin/su -c "dunstify -u 'normal' -r 300 '$message'" $user