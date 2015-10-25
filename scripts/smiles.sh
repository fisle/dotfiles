#!/bin/bash


cd /tmp
LATESTGAJIM=$(curl https://eddykk.com/api/page/gajim | cut -d '"' -f2)
wget https://eddykk.com/smiley/gajim/$LATESTGAJIM
unzip $LATESTGAJIM
filename=$(basename "$LATESTGAJIM")
filename="${filename%.*}"
gksudo mv $filename /usr/share/gajim/data/emoticons/
rm $LATESTGAJIM


LATESTPIDGIN=$(curl https://eddykk.com/api/page/pidgin | cut -d '"' -f2)
wget https://eddykk.com/smiley/pidgin/$LATESTPIDGIN
unzip $LATESTPIDGIN
filename=$(basename "$LATESTPIDGIN")
filename="${filename%.*}"
mv $filename ~/.purple/smileys/
rm $LATESTPIDGIN

notify-send 'Smilies extracted' -u critical -t 5000
