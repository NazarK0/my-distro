#!/bin/bash

username=$(id -u -n 1000)
usrhome= $(/home/$username)
builddir=$($usrhome/build)
mkdir -p $builddir

# Add to Debian backports branch
echo ./sources.list >> /etc/apt/sources.list

# Update packages list
apt update

apt install sudo unzip picom bspwm polybar deepin-terminal zsh rofi neofetch sxhkd lxpolkit lxappearance fonts-material-design-icons-iconfont pulseaudio -y
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

cp .bashrc /root/

su $username

mkdir -p $usrhome/.config
mkdir -p $usrhome/Pictures
mkdir -p /usr/share/sddm/themes
cp .Xresources $usrhome
cp .Xdefaults $usrhome
xrdb ~/.Xresources
xrdb -merge ~/.Xresources

cp -R dotfiles/* $usrhome/.config/
cp background.jpg $usrhome/Pictures/
chown -R $username:$username $usrhome
tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
cp dotfiles/sddm.conf /etc/sddm.conf 

#configure zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
p10k configure
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
$usrhome/.zshrc >> plugins=(zsh-autosuggestions git)
source ~/.zshrc

git clone https://github.com/vinceliuice/Layan-cursors
cd Layan-cursors
sudo ./install.sh
sudo mkdir -p /usr/share/icons/default/
echo "[Icon Theme]" | sudo tee /usr/share/icons/default/index.theme > /dev/null
echo "Inherits=Layan-cursors" | sudo tee -a /usr/share/icons/default/index.theme > /dev/null
# Powermenu Unicode problem fix
cd ../
git clone https://github.com/adi1090x/rofi.git
mkdir -p $usrhome/.local/share/fonts
cp -rf rofi/fonts/* $usrhome/.local/share/fonts/

cp .bashrc $usrhome/

rm -rf $builddir

echo "Done!"
