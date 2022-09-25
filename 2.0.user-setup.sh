#!/bin/bash

mkdir -p $HOME/.config
mkdir -p $HOME/Pictures
mkdir -p $HOME/Downloads
mkdir -p $HOME/Music
mkdir -p $HOME/Books
mkdir -p $HOME/Projects
mkdir -p $HOME/Programs

sudo chown -R $USER:$USER $HOME

sudo apt install zsh papirus-icon-theme fonts-noto-color-emoji fonts-firacode fonts-material-design-icons-iconfont -y
sudo apt install firefox-esr neofetch -y

cp -R dotfiles/* $HOME/.config/
cp background.jpg $HOME/Pictures/

git clone https://github.com/vinceliuice/Layan-cursors.git /tmp/cursors
# cd Layan-cursors
sudo /tmp/cursors/install.sh

echo "[Icon Theme]" | sudo tee /usr/share/icons/default/index.theme > /dev/null
echo "Inherits=Layan-cursors" | sudo tee -a /usr/share/icons/default/index.theme > /dev/null
# Powermenu Unicode problem fix
cd ../
git clone https://github.com/adi1090x/rofi.git /tmp/rofi
mkdir -p $HOME/.local/share/fonts
cp -rf /tmp/rofi/fonts/* $HOME/.local/share/fonts/

#configure zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" -y

