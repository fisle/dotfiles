#!/bin/bash
if (xrandr | grep "DP2-2 connected"); then
    xrandr --output DP2-2 --auto --primary --output eDP1 --auto --right-of DP2-2
else
    xrandr --output eDP1 --primary --output DP2-2 --off
fi
nitrogen --restore
i3-msg restart
