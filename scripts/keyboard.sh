#!/bin/bash
setxkbmap fi
xmodmap -e "keycode 49 = less greater less greater bar brokenbar bar"
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "Caps_Lock = Scroll_Lock"
setxkbmap -option "nbsp:none"
xsetroot -cursor_name left_ptr
