#!/bin/bash

get_status () {
    dpms=$(xset q | awk '/DPMS is Enabled/')
    if [ ! -z "$dpms" ]; then
        status="on"
    else
        status="off"
    fi
    echo $status
}

toggle_dpms () {
    if [ "$(get_status)" == "on" ]; then
        xset -dpms
        xset s off
    else
        xset +dpms
        xset s on
    fi
    pkill -RTMIN+9 i3blocks
}

case $BLOCK_BUTTON in 
    1) toggle_dpms ;;
esac

status=$(get_status)

echo "dpms: $status"
echo "dpms: $status"
