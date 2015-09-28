#!/bin/bash
SPOTIFY=$(pidof spotify)
if [ "$SPOTIFY" ]; then
    COMMAND="playerctl"
else
    COMMAND="mpc"
fi

FIX=$1
if [ $COMMAND == "playerctl" ]; then
    if [ $1 == "prev" ]; then
        FIX="previous"
    fi
    if [ $1 == "toggle" ]; then
        FIX="play-pause"
    fi
fi

$COMMAND $FIX
