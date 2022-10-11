#!/bin/bash

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

mkdir -p $HOME/.config

cd configuration

cp .Xresources $HOME/
cp .Xdefaults $HOME/
cp -R .config/* $HOME/.config/


# load Fn keybindings(acpid events)
sudo cp -r acpid/* /etc/acpi/

# load theme for sddm
sudo mkdir -p /usr/share/sddm/themes
sudo tar -xzf sugar-candy-patched.tar.gz --directory /usr/share/sddm/themes
sudo cp sddm.conf /etc/sddm.conf 


#configure zsh
chsh -s /bin/zsh
sh -c "$(wget -P $downloadDir https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" --unattended

sudo git clone https://github.com/romkatv/powerlevel10k.git --depth=1 $ZSH_CUSTOM/themes/powerlevel10k/ 
pattern=$(grep ^ZSH_THEME="*" $HOME/.zshrc)
sed -i "s#$pattern#ZSH_THEME=\"powerlevel10k/powerlevel10k\"#g" $HOME/.zshrc

#install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
wget -P $ZSH_CUSTOM/plugins/zsh-web-search https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/web-search/web-search.plugin.zsh $ZSH_CUSTOM/plugins/zsh-web-search
wget -P $ZSH_CUSTOM/plugins/zsh-json-tools https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/jsontools/jsontools.plugin.zsh

sudo reboot