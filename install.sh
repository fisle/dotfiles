#!/bin/bash
ROOT=1
if [[ $EUID -ne 0 ]]; then
    ROOT=0
fi

current_folder=$(pwd)

echo "Hello! I will install zsh, tmux and vim configs for user of your choice"
if [ $ROOT -eq 1 ]
then
    echo "I will also install them for root user"
else
    echo "Not run with superuser rights - won't be installed for root"
fi

echo "Hit CTRL+C to cancel"
echo "======="
echo "Enter username:"
read input_user


for i in .Xdefaults .vim .vimrc .tmux.conf .zshrc scripts
do
    ln -s "$(pwd)/$i" "/home/$input_user/$i"
done

mkdir -p /home/$input_user/.config/dunst
ln -s "$(pwd)/dunstrc" "/home/$input_user/.config/dunst/dunstrc"

echo "Symlinks created for user $input_user"

if [ $ROOT -eq 1 ]; then
    for i in .Xdefaults .vim .vimrc .tmux.conf .zshrc_root
    do
        if [ $i == ".zshrc_root" ]; then
            ln -s "$(pwd)/$i" "/root/.zshrc"
        else
            ln -s "$(pwd)/$i" "/root/$i"
        fi
    done
    echo "Symlinks created for root"
fi

sudo ln -s "$current_folder/00-keyboard.conf" /etc/X11/xorg.conf.d/00-keyboard.conf
sudo ln -s "$current_folder/30-natural-scrolling-tapping.conf" /etc/X11/xorg.conf.d/30-natural-scrolling-tapping.conf

echo "All done! Quitting."
