apt install unzip picom bspwm polybar deepin-terminal rofi neofetch sxhkd git lxpolkit lxappearance fonts-material-design-icons-iconfont -y
apt install feh lxappearance fonts-noto-color-emoji fonts-firacode libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Fira Code Nerd Font variant needed
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
fc-cache -vf

cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/Pictures
mkdir -p /usr/share/sddm/themes
cp .Xresources /home/$username
cp .Xnord /home/$username
cp -R dotfiles/* /home/$username/.config/
cp background.jpg /home/$username/Pictures/
chown -R $username:$username /home/$username
tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
cp dotfiles/sddm.conf /etc/sddm.conf 



https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
