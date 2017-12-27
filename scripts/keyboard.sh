#!/bin/bash
setxkbmap fi
setxkbmap -option "nbsp:none"
setxkbmap -option "caps:escape"
xmodmap -e "keycode 49 = less greater less greater bar brokenbar bar"
xmodmap -e "keycode 9 = less greater less greater bar brokenbar bar"
xmodmap -e "keycode 135 = Shift_L"
# xmodmap -e "remove Lock = Caps_Lock"
# xmodmap -e "Caps_Lock = Scroll_Lock"
xsetroot -cursor_name left_ptr
