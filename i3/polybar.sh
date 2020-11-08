#!/bin/sh
echo "Killing polybar...";
killall -q polybar;

echo "Waiting for polybar to die...";
deadline=$(($(date +%s) + 10));
while pgrep -u $UID -x polybar >/dev/null; do
    sleep 0.5;
    [ $deadline -gt $(date +%s) ] || (
        echo "Timed out, force-killing...";
        killall -q -KILL polybar;
    );
done

echo "Running polybar::main @ LVDS1...";
MONITOR=LVDS1 polybar main & disown;
echo "Running polybar::tray @ LVDS1...";
MONITOR=LVDS1 polybar tray & disown;

if xrandr | grep "VGA1 connected" >/dev/null 2>&1; then
	echo "Configuring VGA1...";
	xrandr --output LVDS1 --auto \
		--output VGA1 --right-of LVDS1 --auto;
	echo "Running polybar::main @ VGA1...";
	MONITOR=VGA1 polybar main & disown;
fi


