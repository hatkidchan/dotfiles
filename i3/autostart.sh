#!/bin/bash
# BG_IMAGE=$HOME/.local/share/wallpaper.png

killall -q polybar;
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
MONITOR=LVDS1 polybar main & disown;
MONITOR=LVDS1 polybar tray & disown;

if xrandr | grep "VGA1 connected" >/dev/null 2>&1; then
	xrandr --output LVDS1 --auto \
		--output VGA1 --right-of LVDS1 --auto;
	MONITOR=VGA1 polybar main & disown;
	MONITOR=VGA1 polybar tray & disown;
    sleep 1; killall -USR1 polybar;
fi

# hsetroot -cover $BG_IMAGE;
nitrogen --restore & disown;
xset r rate 250 25;
compton & disown;
nm-applet & disown;
clipit & disown;
