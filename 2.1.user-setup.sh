git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
source $HOME/.zshrc
p10k configure
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo plugins=(zsh-autosuggestions git) >> $HOME/.zshrc
source $HOME/.zshrc

git clone https://github.com/vinceliuice/Layan-cursors
cd Layan-cursors
sudo ./install.sh
sudo mkdir -p /usr/share/icons/default/
echo "[Icon Theme]" | sudo tee /usr/share/icons/default/index.theme > /dev/null
echo "Inherits=Layan-cursors" | sudo tee -a /usr/share/icons/default/index.theme > /dev/null
# Powermenu Unicode problem fix
cd ../
git clone https://github.com/adi1090x/rofi.git
mkdir -p $HOME/.local/share/fonts
cp -rf rofi/fonts/* $HOME/.local/share/fonts/

rm -rf $builddir

echo "Done!"