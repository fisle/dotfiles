#!/bin/sh
xrandr --output VIRTUAL1 --off --output DP2 --off --output DP1 --off --output HDMI2 --off --output HDMI1 --mode 1920x1080i --pos 1600x0 --rotate normal --output eDP1 --auto --output VGA1 --off
nitrogen --restore
