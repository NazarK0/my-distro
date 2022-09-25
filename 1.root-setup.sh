#!/bin/bash

username=$(id -u -n 1000)
usrhome= $(/home/$username)
builddir=$(/tmp/build)
mkdir -p $builddir

# Add to Debian backports branch
cat ./sources.list >> /etc/apt/sources.list

# Update packages list
apt update

apt install sudo zip unzip picom bspwm polybar deepin-terminal zsh rofi neofetch sxhkd lxpolkit lxappearance fonts-material-design-icons-iconfont pulseaudio -y
apt install papirus-icon-theme feh lxappearance fonts-noto-color-emoji fonts-firacode libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 -y

usermod -aG sudo $username

cd $builddir

# Download Nordic Theme
git clone https://github.com/EliverLara/Nordic.git --depth=1
cp ./Nordic/ /usr/share/themes/

# Fira Code Nerd Font variant needed
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
cp /usr/share/fonts/* /usr/share/fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
fc-cache -vf

su $username


