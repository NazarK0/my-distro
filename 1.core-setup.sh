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

apt install sudo sddm bspwm pulseaudio feh psmisc picom sxhkd libqt5svg5 qml-module-qtquick-controls -y
apt install qml-module-qtquick-controls2 tint2 zip unzip x11-xserver-utils -y

systemctl enable sddm
systemctl set-default graphical.target

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

# install fonts
apt install -y fonts-noto-color-emoji fonts-firacode fonts-font-awesome fonts-powerline
cp ./fonts/* /usr/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip
unzip v2.2.2.zip -d /usr/share/fonts

fc-cache -vf

# install terminal emulator
apt install -y kitty

# user setup operations
/usr/sbin/usermod -aG sudo $username
chmod -R 770 /mydistro
chown -R :users /mydistro
/usr/sbin/usermod -aG users $username
chown -R $username:users /home/$username