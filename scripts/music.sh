#!/bin/bash
DATA=$(mpc playlist --format "%artist% - %title%\`%position%" | grep -F -f <(mpc playlist | fzf) | cut -d '`' -f2)
echo $DATA
if [ ! -z "$DATA" ]
then
    mpc play $DATA
fi
