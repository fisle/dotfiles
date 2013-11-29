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
echo "All done! Quitting."
