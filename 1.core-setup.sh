#!/bin/bash

username=$(id -u -n 1000)
mkdir -p /home/$username/tmp
downloadDir=/home/$username/tmp
repoDir=$(pwd)
logfile=/var/log/distro-install.log

echo 'Update packages list...'
apt update >> $logfile 2>&1

echo 'Install core packages...'

{
  #tools
  apt install net-tools tree network-manager htop fdisk -y
} >> $logfile 2>&1

echo 'install build dependencies...'
apt install build-essential gcc libssl-dev libncurses-dev libpulse-dev -y >> $logfile 2>&1
echo 'install cmake...'
wget -P $downloadDir https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz >> $logfile 2>&1
mkdir $downloadDir/cmake-src
tar -zxf $downloadDir/cmake-*.tar.gz --directory $downloadDir/cmake-src --strip-components 1
cd $downloadDir/cmake-src || exit
{
  ./bootstrap
  make
  make install
} >> $logfile 2>&1
cd $repoDir || exit

echo 'install fonts...'
apt install -y fonts-noto-color-emoji fonts-firacode fonts-font-awesome fonts-powerline ttf-mscorefonts-installer >> $logfile 2>&1
cp ./fonts/* /usr/share/fonts

wget -P $downloadDir/nerd-fonts https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip >> $logfile 2>&1
unzip $downloadDir/nerd-fonts/v2.2.2.zip -d /usr/share/fonts

fc-cache -vf >> $logfile 2>&1

echo 'install terminal emulator...'
apt install -y zsh >> $logfile 2>&1

# user setup operations
echo 'update user home directory'
mkdir /home/"$username"/books
mkdir /home/"$username"/projects
mkdir /home/"$username"/programs
mkdir /home/"$username"/virtualMachines

chmod -R 700 /home/"$username"
chown -R "$username":"$username" /home/"$username"

echo 'change grub default background'
cp configuration/grub-bg.jpg /usr/share/grub/
echo 'GRUB_BACKGROUND=/usr/share/grub/grub-bg.jpg' >> /etc/default/grub
/usr/sbin/update-grub >> $logfile 2>&1
