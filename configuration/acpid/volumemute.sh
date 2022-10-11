#!/bin/sh

amixer set Capture toggle

is_muted=$(pacmd list-sinks | awk '/muted/ { print $2 }')
message = ''

if [ $is_muted=='yes' ]
then
   message='Викл.'
else
   message='Вкл.'
fi

/bin/su -c "dunstify -u 'normal' -r 200 ' 'Гучність: $message'" $(id -u -n 1000)