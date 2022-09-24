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
