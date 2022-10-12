#!/bin/sh

user=$(id -u -n 1000)

volumes=$(/bin/su -c "amixer set Master 5%+" $user | grep % | awk '{print $5}' | sed 's/[][%]//g')
volume_left=$(echo "${volumes}" | sed -n 1p)
volume_right=$(echo "${volumes}" | sed -n 2p)

/bin/su -c "dunstify -u 'normal' -r 200 -h int:value:$volume_left 'Гучність:\nЛівий: $volume_left\nПравий: $volume_right'" $user

