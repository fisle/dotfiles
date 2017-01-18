#!/bin/bash

function update_gajim () {
    cd /tmp || exit
    LATESTGAJIM=$(curl https://eddykk.com/api/page/gajim | cut -d '"' -f2)
    wget https://eddykk.com/smiley/gajim/"$LATESTGAJIM"
    unzip "$LATESTGAJIM"
    filename=$(basename "$LATESTGAJIM")
    filename="${filename%.*}"
    gksudo mv "$filename" /usr/share/gajim/data/emoticons/
    rm "$LATESTGAJIM"
}

function update_pidgin () {
    LATESTPIDGIN=$(curl https://eddykk.com/api/page/pidgin | cut -d '"' -f2)
    wget https://eddykk.com/smiley/pidgin/"$LATESTPIDGIN"
    unzip "$LATESTPIDGIN"
    filename=$(basename "$LATESTPIDGIN")
    filename="${filename%.*}"
    mv "$filename" ~/.purple/smileys/
    rm "$LATESTPIDGIN"
}

if ls ~/.purple/smileys/ ; then
    echo "Updating pidgin smileys.."
    update_pidgin
fi

if ls /usr/share/gajim/data/emoticons/ ; then
    echo "Updating gajim smileys.."
    update_gajim
fi


notify-send 'Smilies extracted' -u critical -t 5000
