#!/bin/sh

amixer set Capture 5%%+

mixer=/bin/amixer sget Capture

volume=$(awk -F"[][]" '/Left:/ { print $2 }' < $mixer)
volume_value=$($volume | sed 's/%//')
echo $volume_value
/bin/su -c "dunstify -u 'normal' -r 200 -h string:x-dunst-stack-tag:$volume_value -h int:value:"$volume_value" 'Гучність: $volume'" $(id -u -n 1000)