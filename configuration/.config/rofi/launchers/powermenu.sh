#!/usr/bin/env bash

theme="$HOME/.config/rofi/views/powermenu"
messageTheme="$HOME/.config/rofi/views/message"

rofi_command="rofi -theme $theme"

# Options
shutdown="Вимкнути"
reboot="Перезавантажити"
lock="Призупинити"
suspend="Приспати"
logout="Вийти"

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  Так / y / Ні / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
			systemctl shutdown
        ;;
    $reboot)
			systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
			mpc -q pause
			amixer set Master mute
			systemctl suspend
        ;;
    $logout)
			bspc quit
esac