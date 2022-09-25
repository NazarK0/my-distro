$ZSH_CUSTOM$ = $HOME/.oh-my-zsh/custom
sudo git clone https://github.com/romkatv/powerlevel10k.git --depth=1 $ZSH_CUSTOM/themes/powerlevel10k/ 
sed -i 's#^ZSH_THEME="*"$#ZSH_THEME="powerlevel10k/powerlevel10k"#g' $HOME/.zshrc

source $HOME/.zshrc
p10k configure
# git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# echo plugins=(zsh-autosuggestions git) >> $HOME/.zshrc
# source $HOME/.zshrc


#rm -rf /tmp/*
echo "Done!"