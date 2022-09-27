#!/bin/bash

mkdir -p /usr/build-distro
mkdir -p /usr/git-distro

username=$(id -u -n 1000)
builddir=/usr/build-distro
gitdir=/usr/git-distro

# Add to apt all necessary repos
cat ./sources.list >> /etc/apt/sources.list

# Delete cdrom from apt source.list
sed -i 's/^deb cdrom:*/#/' /etc/apt/sources.list

# Update packages list
apt update

apt install sudo xorg pulseaudio feh psmisc picom sxhkd libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 tint2 bspwn zip unzip -y

# picom build dependencies
#apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y

# ly build dependencies
apt install build-essential libpam0g-dev libxcb-xkb-dev -y

#ncpamixer build dependencies
apt install libncurses-dev libpulse-dev -y

apt install fonts-powerline -y

# install xmenu
git clone https://github.com/phillbush/xmenu.git --depth=1 $gitdir/xmenu
cd $gitdir/xmenu
make
make install

# install ncpamixer
git clone https://github.com/fulhax/ncpamixer.git --depth=1 $gitdir/ncpamixer
cd $gitdir/ncpamixer
make USE_WIDE=True

# install Ly
git clone --recurse-submodules https://github.com/fairyglade/ly $gitdir/ly
cd $gitdir/ly
make
make install installsystemd
systemctl enable ly.service

#install window manager
systemctl set-default graphical.target

# install fonts
cp fonts/* /usr/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip
unzip v2.2.2.zip -d /usr/share/fonts

fc-cache -vf

#user specific operations
usermod -aG sudo $username
chown -R $username $builddir
