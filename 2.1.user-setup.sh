git clone https://github.com/romkatv/powerlevel10k.git /tmp/l10k
cp -rv /tmp/l10k/* $ZSH_CUSTOM/themes/powerlevel10k/
cd $HOME
source .zshrc
p10k configure
# git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# echo plugins=(zsh-autosuggestions git) >> $HOME/.zshrc
# source $HOME/.zshrc

echo "Done!"