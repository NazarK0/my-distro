#!/bin/sh

user=$(id -u -n 1000)
pactl set-sink-mute 0 toggle

metadata=$(/bin/su -c "amixer get Master" $user)

volumes=$(echo "{$metadata}" | grep % | awk '{print $5}' | sed 's/[][%]//g')
volume_left=$(echo "${volumes}" | sed -n 1p)
volume_right=$(echo "${volumes}" | sed -n 2p)

status=$(echo "{$metadata}" | grep % | awk '{print $6}' | sed 's/[][]//g' | sed -n 1p)

if [ $status = 'off' ]
then
   message='Звук: Викл.'
elif [ $status = 'on' ]
then
   message="-h int:value:$volume_left Звук: Вкл. Гучність:\nЛівий: $volume_left\nПравий: $volume_right"
fi

/bin/su -c "dunstify -u 'normal' -r 200 $message" $user
