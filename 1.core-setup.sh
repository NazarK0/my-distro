#!/bin/bash

mkdir -p /distro-src/download

username=$(id -u -n 1000)
downloadDir=/distro-src/download
repoDir=/distro-src/my-distro
logfile=/distro-src/distro-install.log

echo 'Add to apt all necessary repos'
cat ./sources.list >> /etc/apt/sources.list

echo 'Delete cdrom from apt source.list'
sed -i 's/^deb cdrom:*/#/' /etc/apt/sources.list

echo 'Update packages list...'
apt update >> $logfile 2>&1

echo 'Install core packages...'

{
  apt install sudo sddm rofi bspwm pulseaudio feh psmisc picom sxhkd -y
  apt install zip unzip x11-xserver-utils scrot dunst network-manager -y
  apt install xscreensaver xscreensaver-data-extra xscreensaver-gl-extra rss-glx -y
  apt -t bullseye-backports install -y polybar
  #dependencies for sddm theme
  apt install libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 -y
} >> $logfile 2>&1

{
  systemctl enable sddm
  systemctl enable NetworkManager
} >> $logfile 2>&1

systemctl set-default graphical.target

echo 'install ncpamixer build dependencies...'
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

echo 'install ncpamixer...'
git clone https://github.com/fulhax/ncpamixer.git --depth=1 $downloadDir/ncpamixer >> $logfile 2>&1
cd $downloadDir/ncpamixer || exit
make USE_WIDE=True >> $logfile 2>&1
cd $repoDir || exit

echo 'install fonts...'
apt install -y fonts-noto-color-emoji fonts-firacode fonts-font-awesome fonts-powerline ttf-mscorefonts-installer >> $logfile 2>&1
cp ./fonts/* /usr/share/fonts

wget -P $downloadDir/nerd-fonts https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.2.2.zip >> $logfile 2>&1
unzip $downloadDir/nerd-fonts/v2.2.2.zip -d /usr/share/fonts

fc-cache -vf >> $logfile 2>&1

echo 'install terminal emulator...'
apt install -y kitty >> $logfile 2>&1

# user setup operations
echo 'update user home directory'
mkdir /home/"$username"/images
mkdir /home/"$username"/audio
mkdir /home/"$username"/desktop
mkdir /home/"$username"/downloads
mkdir /home/"$username"/documents
mkdir /home/"$username"/projects
mkdir /home/"$username"/programs
mkdir /home/"$username"/virtualMachines
mkdir /home/"$username"/shared

echo 'add user to sudoers'
/usr/sbin/usermod -aG sudo "$username"

chmod -R 770 /distro-src
chown -R :users /distro-src

/usr/sbin/usermod -aG users "$username"

chmod -R 700 /home/"$username"
chown -R "$username":"$username" /home/"$username"

chmod -R 770 /home/"$username"/shared
chown -R "$username":users /home/"$username"/shared

echo 'change grub default background'
cp configuration/grub-bg.jpg /usr/share/grub/
echo 'GRUB_BACKGROUND=/usr/share/grub/grub-bg.jpg' >> /etc/default/grub
update-grub >> $logfile 2>&1
