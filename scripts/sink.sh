#!/bin/bash
sinkinputs=$(pactl list short sink-inputs | cut -f1)
current=$(cat ~/.sink)
sinks=$(pactl list short sinks | cut -f1)
count=$(pactl list short sinks | wc -l)
count=$(expr $count - 1)

if [ $current == $count ]; then
    output=0
else
    output=$(expr $current + 1)
fi

pacmd set-default-sink $output
echo $output > ~/.sink

notify-send "$(pactl list sinks | grep device.description | head -$(expr $output + 1) | tail -1 | grep -oP '"\K[^"\047]+(?=["\047])')"

for sink in $sinkinputs
do
    pacmd move-sink-input $sink $output
done

