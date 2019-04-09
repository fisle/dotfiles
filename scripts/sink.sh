#!/bin/bash
function get_sinks_short() {
    pactl list short sinks | cut -f1
}
function get_inputs() {
    pactl list short sink-inputs | cut -f1
}

function get_sink_name() {
    sink="$1"

    if [ -z "$sink" ]; then
        echo "No sink specified"
        return
    fi

    pactl list sinks | grep device.description | sed "$sink"'q;d' | grep -oP '"\K[^"\047]+(?=["\047])'
}

function set_default_sink() {
    output="$1"

    if [ -z "$output" ]; then
        echo "No output specified"
        return
    fi

    pacmd set-default-sink "$output"
    sink_name=$(get_sink_name "$((output + 1))")
    printf "%s\\n%s" "$output" "$sink_name" > ~/.sink
}

function get_default_sink() {
    head -n1 ~/.sink
}

function get_default_sink_pretty() {
    name=$(tail -n1 ~/.sink)
    echo "${name::35}"
}

function move_inputs() {
    output="$1"

    if [ -z "$output" ]; then
        echo "No output specified"
        return
    fi

    for sink in $(get_inputs)
    do
        pacmd move-sink-input "$sink" "$output"
    done
}

function main() {
    if [ ! -z "$1" ] && [ "$1" == "print" ]; then
        get_default_sink_pretty
        return
    fi

    current=$(get_default_sink)
    sinks=$(get_sinks_short)

    index=$(get_index "$sinks" "$current")

    next_index=$((index + 1))
    next_sink=$(echo "$sinks" | sed "$next_index"'q;d')

    count=$(get_sinks_short | wc -l)

    if [ "$next_index" -gt "$count" ]; then
        next_sink=$(echo "$sinks" | sed '1q;d')
    fi

    set_default_sink "$next_sink"
    move_inputs "$next_sink"

    notify-send "Input changed: $(get_default_sink_pretty)"
}

function get_index() {
    my_array="$1"
    value="$2"

    if [ -z "$my_array" ] || [ -z "$value" ]; then
        echo "Not enough parameters"
        return
    fi

    counter=1
    for item in $my_array
    do
        if [ "$item" == "$value" ]; then
            echo "$counter"
        fi

        (( counter+=1 ))
    done
}

main "$@"
