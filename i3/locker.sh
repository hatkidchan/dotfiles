#!/bin/bash
scrot -za 0,0,1024,600 /tmp/lock.png;
convert /tmp/lock.png -blur 2x2 /tmp/lock.png
i3lock -nec 131313;
rm /tmp/lock.png;
