#!/bin/sh

{
bl_dev=/sys/class/backlight/intel_backlight
max_brightness=$(cat $bl_dev/max_brightness)
step=1 #user value, in percent 1-100

item=30
total=70
percent=$((200*$item/$total % 2 + 100*$item/$total))




actual_step = $(($step * $max_brightness)/ 100)
echo "env variable=$1"

case $1 in
  video/brightnessdown) echo $(($(< $bl_dev/brightness) - $step)) >$bl_dev/brightness;;
  video/brightnessup) echo $(($(< $bl_dev/brightness) + $step)) >$bl_dev/brightness;;
esac
} >> /tmp/test-acpi.log 2>&1
