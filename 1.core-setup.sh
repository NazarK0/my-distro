#!/bin/bash

mkdir -p /distro-src/download

username=$(id -u -n 1000)
downloaddir=/distro-src/download
repodir=/distro-src/my-distro

# Add to apt all necessary repos
cat ./sources.list >> /etc/apt/sources.list

# Delete cdrom from apt source.list
sed -i 's/^deb cdrom:*/#/' /etc/apt/sources.list

# Update packages list
apt update >> distro-install.log 2>&1

apt install sudo sddm bspwm pulseaudio feh psmisc picom sxhkd -y >> distro-install.log 2>&1
apt install tint2 zip unzip x11-xserver-utils -y >> distro-install.log 2>&1
#dependencies for sddm theme 
apt install libqt5svg5 qml‑module‑qtquick‑layouts qml-module-qtquick-controls qml-module-qtquick-controls2 qml‑module‑qtgraphicaleffects -y >> distro-install.log 2>&1

systemctl enable sddm
systemctl set-default graphical.target

# xmenu build dependencies
apt install -y libimlib2-dev libx11-dev libxinerama-dev libxft-dev >> distro-install.log 2>&1
# install xmenu
git clone https://github.com/phillbush/xmenu.git --depth=1 $downloaddir/xmenu
cd $downloaddir/xmenu
make >> distro-install.log 2>&1
make install >> distro-install.log 2>&1
cd $repodir

#ncpamixer build dependencies
apt install build-essential gcc libssl-dev libncurses-dev libpulse-dev -y >> distro-install.log 2>&1
#install cmake
wget https://github.com/Kitware/CMake/releases/download/v3.21.0/cmake-3.21.0.tar.gz $downloaddir/cmake
tar xvf $downloaddir/cmake/cmake-3.21.0.tar.gz
cd $downloaddir/cmake/cmake-3.21.0 
./bootstrap >> distro-install.log 2>&1
gmake >> distro-install.log 2>&1
make install >> distro-install.log 2>&1
cd $repodir

# install ncpamixer
git clone https://github.com/fulhax/ncpamixer.git --depth=1 $downloaddir/ncpamixer
cd $downloaddir/ncpamixer
make USE_WIDE=True >> distro-install.log 2>&1
cd $repodir

# install fonts
apt install -y fonts-noto-color-emoji fonts-firacode fonts-font-awesome fonts-powerline >> distro-install.log 2>&1
cp ./fonts/* /usr/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip $downloaddir/nerd-fonts
unzip $downloaddir/nerd-fonts/v2.2.2.zip -d /usr/share/fonts

fc-cache -vf >> distro-install.log 2>&1

# install terminal emulator
apt install -y kitty >> distro-install.log 2>&1

# user setup operations
mkdir /home/$username/images
mkdir /home/$username/audio
mkdir /home/$username/desktop
mkdir /home/$username/downloads
mkdir /home/$username/documents
mkdir /home/$username/projects
mkdir /home/$username/programs
mkdir /home/$username/virtualMachines
mkdir /home/$username/shared

/usr/sbin/usermod -aG sudo $username

chmod -R 770 /mydistro
chown -R :users /mydistro

/usr/sbin/usermod -aG users $username

chmod -R 700 /home/$username
chown -R $username:$username /home/$username

chmod -R 770 /home/$username/shared
chown -R $username:users /home/$username/shared

# change grub default background
mv configuration/grub-bg.jpg /usr/share/grub/grub-bg.jpg
echo 'GRUB_BACKGROUND=/usr/share/grub/grub-bg.jpg' >> /etc/default/grub
update-grub