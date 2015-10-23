#!/bin/bash
if (xrandr | grep "HDMI1 disconnected"); then
    xrandr --output eDP1 --primary --output HDMI1 --off
else
    xrandr --output HDMI1 --auto --primary --output eDP1 --auto --right-of HDMI1
fi
