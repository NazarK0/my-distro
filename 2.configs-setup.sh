#!/bin/bash

cd configuration
cp .dircolors $HOME/

#configure zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" --unattended

sudo apt purge -y gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg \
gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex \
pidgin thunderbird hexchat synaptic libreoffice\*

sudo reboot
