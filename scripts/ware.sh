#!/bin/bash
url=$(xclip -o)
folder="~/Downloads/"
cd $folder
wget -r -nH --cut-dirs=2 --no-parent $url && notify-send 'gcomp parsa muut varsa' -u critical -t 5000
