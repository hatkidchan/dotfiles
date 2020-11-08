#!/bin/sh

$(dirname "$0")/polybar.sh;

hsetroot -solid '#131313';
(nitrogen --restore || true) & disown;
xset r rate 250 25;
xcompmgr & disown;
nm-applet & disown;
(clipit || true) & disown;

setxkbmap -option grp:alt_shift_toggle;
[ -f "${HOME}/.local/share/xkb" ] \
    && xkbcomp "${HOME}/.local/share/xkb" :0 2>/dev/null;
synclient HorizTwoFingerScroll=1 TapButton1=1 TapButton2=3 TapButton3=2;

