#!/bin/bash
# scrot -s '/tmp/%Y-%m-%d_%H-%M-%S.png' -e 'scp $f eddy:/home/edgar/nginx/eddykk/public_page/ss/fisle/ && echo "https://eddykk.com/ss/fisle/$n"|xclip'

# scrot -s '/tmp/%Y-%m-%d_%H-%M-%S.png' -e '~/scripts/eddy.sh $f'

maim -s /tmp/screenshot.png ; ~/scripts/eddy.sh /tmp/screenshot.png | xclip -selection clipboard && notify-send "Image uploaded"
