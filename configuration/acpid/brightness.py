#!/usr/bin/python3

import sys,re,os

STEP = "5%"

br_dev = "/sys/class/backlight/intel_backlight"
pressed_btn = sys.argv[1]
brightness_up_id = "video/brightnessup"
brightness_down_id = "video/brightnessdown"
step_value = int(re.findall(r'\d+', STEP)[0])

with open(f"{br_dev}/max_brightness", 'r') as file:
    br_max_value = int(file.read().rstrip())

with open(f"{br_dev}/brightness", 'r') as file:
    br_current_value = int(file.read().rstrip())

delta = round((step_value * br_max_value) / 100)

if pressed_btn == brightness_up_id:
	br_value = br_current_value + delta
	
elif pressed_btn == brightness_down_id:
	br_value = br_current_value - delta
else:
	br_value = br_current_value


if br_value < 1: 
	br_value = 1
elif br_value > br_max_value:
	br_value = br_max_value


f = open(f"{br_dev}/brightness", "w")
f.write(str(br_value))
f.close()

br_percentage = round((br_value / br_max_value) * 100)

os.system(f"/bin/su -c \"dunstify -u 'normal' -r 100 -h int:value:{br_percentage} -i 'brightness-$1' 'Яскравість: {br_percentage}%'\" $(id -u -n 1000)")
