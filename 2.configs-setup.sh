#!/bin/bash


oh_my_zsh=$HOME/.oh-my-zsh

mkdir -p $HOME/.config

cd configuration

cp .Xresources $HOME/
cp .Xdefaults $HOME/
cp -R .config/* $HOME/.config/

cp .dircolors $HOME/

# load Fn keybindings(acpid events)
sudo cp -r acpid/* /etc/acpi/

# load theme for sddm
sudo mkdir -p /usr/share/sddm/themes
sudo tar -xzf sugar-candy-patched.tar.gz --directory /usr/share/sddm/themes
sudo cp sddm.conf /etc/sddm.conf 


#configure zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" --unattended

sudo reboot