#!/bin/bash


cd /tmp
LATESTGAJIM=$(curl 'https://eddykk.com/api/latest.php?service=smile&type=gajim' | jsawk 'return this.content')
wget https://eddykk.com/smiles/$LATESTGAJIM
unzip $LATESTGAJIM
filename=$(basename "$LATESTGAJIM")
filename="${filename%.*}"
gksudo mv $filename /usr/share/gajim/data/emoticons/
rm $LATESTGAJIM


LATESTPIDGIN=$(curl 'https://eddykk.com/api/latest.php?service=smile&type=pidgin' | jsawk 'return this.content')
wget https://eddykk.com/smiles/$LATESTPIDGIN
unzip $LATESTPIDGIN
filename=$(basename "$LATESTPIDGIN")
filename="${filename%.*}"
mv $filename ~/.purple/smileys/
rm $LATESTPIDGIN

notify-send 'Smilies extracted' -u critical -t 5000
