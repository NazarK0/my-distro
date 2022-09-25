#!/bin/bash

mkdir -p /tmp/build

username=$(id -u -n 1000)
builddir=/tmp/build

# Add to Debian backports branch
cat ./sources.list >> /etc/apt/sources.list

sleep 2

sed -i 's/^deb cdrom:*/#/' /etc/apt/sources.list
sleep 2

# Update packages list
apt update

apt install sudo zip unzip picom bspwm deepin-terminal rofi sxhkd lxpolkit lxappearance pulseaudio -y
apt install feh lxappearance libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 x11-xserver-utils -y
sudo apt -t bullseye-backports install polybar -y

systemctl enable sddm
systemctl set-default graphical.target

usermod -aG sudo $username

mkdir -p /usr/share/sddm/themes
mkdir -p /usr/share/icons/default/

cp .Xresources /home/$username/
cp .Xdefaults /home/$username/
xrdb $HOME/.Xresources
xrdb -merge $HOME/.Xresources

cp dotfiles/sddm.conf /etc/sddm.conf
tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
sleep 2

cd $builddir
sleep 2

# Download Nordic Theme
git clone https://github.com/EliverLara/Nordic.git --depth=1 /usr/share/themes/

# Fira Code Nerd Font variant needed
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
cp /usr/share/fonts/* /usr/share/fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
fc-cache -vf

chown -R $username $builddir
cd ../my-distro

su $username


