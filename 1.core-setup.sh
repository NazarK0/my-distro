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
apt update 2>&1 | tee -a distro-install.log

apt install sudo sddm bspwm pulseaudio feh psmisc picom sxhkd -y 2>&1 | tee -a distro-install.log
apt install tint2 zip unzip x11-xserver-utils -y 2>&1 | tee -a distro-install.log
#dependencies for sddm theme 
apt install libqt5svg5 qml‑module‑qtquick‑layouts qml-module-qtquick-controls qml-module-qtquick-controls2 qml‑module‑qtgraphicaleffects -y 2>&1 | tee -a distro-install.log

systemctl enable sddm
systemctl set-default graphical.target

# xmenu build dependencies
apt install -y libimlib2-dev libx11-dev libxinerama-dev libxft-dev 2>&1 | tee -a distro-install.log
# install xmenu
git clone https://github.com/phillbush/xmenu.git --depth=1 $downloaddir/xmenu
cd $downloaddir/xmenu
make 2>&1 | tee -a distro-install.log
make install 2>&1 | tee -a distro-install.log
cd $repodir

#ncpamixer build dependencies
apt install build-essential gcc libssl-dev libncurses-dev libpulse-dev -y 2>&1 | tee -a distro-install.log
#install cmake
wget https://github.com/Kitware/CMake/releases/download/v3.21.0/cmake-3.21.0.tar.gz $downloaddir/cmake
tar xvf $downloaddir/cmake/cmake-3.21.0.tar.gz
cd $downloaddir/cmake/cmake-3.21.0 
./bootstrap 2>&1 | tee -a distro-install.log
gmake 2>&1 | tee -a distro-install.log
make install 2>&1 | tee -a distro-install.log
cd $repodir

# install ncpamixer
git clone https://github.com/fulhax/ncpamixer.git --depth=1 $downloaddir/ncpamixer
cd $downloaddir/ncpamixer
make USE_WIDE=True 2>&1 | tee -a distro-install.log
cd $repodir

# install fonts
apt install -y fonts-noto-color-emoji fonts-firacode fonts-font-awesome fonts-powerline 2>&1 | tee -a distro-install.log
cp ./fonts/* /usr/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip $downloaddir/nerd-fonts
unzip $downloaddir/nerd-fonts/v2.2.2.zip -d /usr/share/fonts

fc-cache -vf 2>&1 | tee -a distro-install.log

# install terminal emulator
apt install -y kitty 2>&1 | tee -a distro-install.log

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