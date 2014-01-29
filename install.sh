#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
echo "This script will install vim configs for root user and user of your choice"
echo "Hit CTRL+C to cancel"
echo "======="
echo "Enter username:"
read input_user
echo "Creating symlink /root/.vim to `pwd`/.vim"
ln -s `pwd`/.vim /root/.vim
echo "Creating symlink /root/.vimrc to `pwd`/.vimrc"
ln -s `pwd`/.vimrc /root/.vimrc
echo "Creating symlink /home/$input_user/.vim to `pwd`/.vim"
ln -s `pwd`/.vim /home/$input_user/.vim
echo "Creating symlink /home/$input_user/.vimrc to `pwd`/.vimrc"
ln -s `pwd`/.vimrc /home/$input_user/.vimrc
echo "Creating symlink /home/$input_user/.tmux.conf to `pwd`/.tmux.conf"
ln -s `pwd`/.tmux.conf /home/$input_user/.tmux.conf
echo "Creating symlink /root/.tmux.conf to `pwd`/.tmux.conf"
ln -s `pwd`/.tmux.conf /root/.tmux.conf
echo "Creating symlink /root/.zshrc to `pwd`/.zshrc_root"
ln -s `pwd`/.zshrc_root /root/.zshrc
echo "Creating symlink /home/$input_user/.zshrc to `pwd`/.zshrc"
ln -s `pwd`/.zshrc /home/$input_user/.zshrc
echo "All done! Quitting."
