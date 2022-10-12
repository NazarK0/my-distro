#!/bin/sh

user=$(id -u -n 1000)
/bin/su -c "playerctl play-pause" $user

