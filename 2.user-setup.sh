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


rm -rf $builddir

echo "Done!"