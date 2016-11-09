#!/bin/bash
# First install pacaur, then run this
sudo pacman-key --refresh-keys

sudo pacaur -S \
    arandr \
    blueman \
    cifs-utils \
    clipit \
    curl \
    dmenu \
    dropbox \
    dunst \
    editorconfig-core-c \
    eslint \
    file-roller \
    firefox \
    flake8 \
    fontconfig-infinality \
    fzf \
    galculator \
    gcolor2 \
    git \
    gpicview \
    htop-temperature \
    i3-gaps \
    i3blocks \
    lightdm \
    lightdm-gtk-greeter \
    lxappearance \
    mupdf \
    net-tools \
    nitrogen \
    numix-themes \
    owncloud-client \
    pavucontrol \
    php-codesniffer \
    phpmd \
    ponymix \
    pulseaudio \
    python2-flake8 \
    rxvt-unicode \
    shellcheck \
    spotify \
    the_silver_searcher \
    thunar \
    tig \
    tmux \
    tree \
    ttf-font-awesome \
    ttf-font-icons \
    udiskie \
    unclutter \
    unzip \
    vim \
    volnoti \
    wget \
    xclip \
    xorg-apps \
    xorg-server \
    xorg-server-utils \
    zsh

sudo systemctl enable lightdm.service

printf "Now configure the following:\n
/etc/lightdm/lightdm.conf\n
"
