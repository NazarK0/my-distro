#!/bin/bash

mkdir -p /mydistro/build
mkdir -p /mydistro/git-tmp

username=$(id -u -n 1000)
builddir=/usr/build-distro
gitdir=/usr/git-distro

# Add to apt all necessary repos
cat ./sources.list >> /etc/apt/sources.list

# Delete cdrom from apt source.list
sed -i 's/^deb cdrom:*/#/' /etc/apt/sources.list

# Update packages list
apt update

apt install sudo xorg pulseaudio feh psmisc picom sxhkd libqt5svg5 qml-module-qtquick-controls -y
apt install qml-module-qtquick-controls2 tint2 bspwm zip unzip lxappearance -y

# picom build dependencies
#apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y

apt install fonts-powerline -y

# ly build dependencies
apt install build-essential libpam0g-dev libxcb-xkb-dev -y
# install Ly
git clone --recurse-submodules https://github.com/fairyglade/ly $gitdir/ly
cd $gitdir/ly
make
make install installsystemd
systemctl enable ly.service
#set tty to 7 in /etc/ly/config.ini
systemctl disable getty@tty2.service

# xmenu build dependencies
apt install -y libimlib2-dev libx11-dev libxinerama-dev libxft-dev
# install xmenu
git clone https://github.com/phillbush/xmenu.git --depth=1 $gitdir/xmenu
cd $gitdir/xmenu
make
make install

#ncpamixer build dependencies
apt install build-essential gcc libssl-dev libncurses-dev libpulse-dev -y
#install cmake
wget https://github.com/Kitware/CMake/releases/download/v3.21.0/cmake-3.21.0.tar.gz $builddir/cmake
tar xvf cmake-3.21.0.tar.gz
cd cmake-3.21.0 
./bootstrap 
gmake
make install

# install ncpamixer
git clone https://github.com/fulhax/ncpamixer.git --depth=1 $gitdir/ncpamixer
cd $gitdir/ncpamixer
make USE_WIDE=True

#install window manager
systemctl set-default graphical.target

# install fonts
apt install -y fonts-noto-color-emoji fonts-firacode fonts-font-awesome
cp fonts/* /usr/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip
unzip v2.2.2.zip -d /usr/share/fonts

fc-cache -vf

#install apps
apt install -y kitty

#user specific operations
usermod -aG sudo $username
chown -R $username $builddir
chown -R $username:desktop_users /home/$username

#setup configs
mkdir -p /home/$username/.config
mkdir -p /home/$username/.background
mv config/.Xresources /home/$username/.Xresources
mv config/.Xdefaults /home/$username/.Xdefaults
mv config/background.jpg /home/$username/.background/background.jpg
cp -R config/* /home/$username/.config/
