mkdir -p $HOME/.config
mkdir -p $HOME/Pictures
mkdir -p /usr/share/sddm/themes
cp .Xresources $HOME/
cp .Xdefaults $HOME/
xrdb ~/.Xresources
xrdb -merge ~/.Xresources

cp -R dotfiles/* $HOME/.config/
cp background.jpg $HOME/Pictures/
chown -R $USER:$USER $HOME
tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
cp dotfiles/sddm.conf /etc/sddm.conf 

git clone https://github.com/vinceliuice/Layan-cursors /tmp/
# cd Layan-cursors
sudo /tmp/Layan-cursors/install.sh
sudo mkdir -p /usr/share/icons/default/
echo "[Icon Theme]" | sudo tee /usr/share/icons/default/index.theme > /dev/null
echo "Inherits=Layan-cursors" | sudo tee -a /usr/share/icons/default/index.theme > /dev/null
# Powermenu Unicode problem fix
cd ../
git clone https://github.com/adi1090x/rofi.git /tmp/
mkdir -p $HOME/.local/share/fonts
cp -rf /tmp/rofi/fonts/* $HOME/.local/share/fonts/

rm -rf /tmp/*

#configure zsh
chsh -s /bin/zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
