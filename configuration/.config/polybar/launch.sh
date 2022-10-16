#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

external='HDMI-1'
isExternalConnected=$(xrandr -q | grep -c "$external connected")

if [ $isExternalConnected -eq 1 ]
then
    (sleep 2; polybar --config=$HOME/.config/polybar/config2m.ini bar1) &
    (sleep 2; polybar --config=$HOME/.config/polybar/config2m.ini bar2) &
else
    #default, 1 monitor
    (sleep 2; polybar bar) &
fi
#(sleep 2; polybar tray) &
