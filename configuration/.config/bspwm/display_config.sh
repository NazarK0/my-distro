#!/bin/sh

primary='eDP-1'
external='HDMI-1'

isExternalConnected=$(xrandr -q | grep -c "$external connected")

if [ $isExternalConnected -eq 1 ]
  then
      xrandr --output $primary --primary --rotate normal --mode 1920x1080 --output $external --left-of $primary --rotate normal --mode 1920x1080

      #Monitor Config
      bspc monitor $primary -d 1 2 3 4 5 6 7
      bspc monitor $external -d 8 9 10
  else
      #default, 1 monitor
      #Monitor Config
      bspc monitor $primary -d 1 2 3 4 5 6 7 8 9 10
fi