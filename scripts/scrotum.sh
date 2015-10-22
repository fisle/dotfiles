#!/bin/bash
scrot -s '/tmp/%Y-%m-%d_%H-%M-%S.png' -e 'scp $f eddy:/home/edgar/nginx/eddykk/public_page/ss/fisle/ && echo "https://eddykk.com/ss/fisle/$n"|xclip'
