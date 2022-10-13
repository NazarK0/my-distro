#!/bin/bash

downloaddir=/distro-src/download
logfile=/distro-src/distro-install.log
oh_my_zsh=$HOME/.oh-my-zsh
ZSH_CUSTOM=$oh_my_zsh/custom

# configure zsh theme
git clone https://github.com/romkatv/powerlevel10k.git --depth=1 $ZSH_CUSTOM/themes/powerlevel10k/ 
pattern=$(grep ^ZSH_THEME="*" $HOME/.zshrc)
sed -i "s#$pattern#ZSH_THEME=\"powerlevel10k/powerlevel10k\"#g" $HOME/.zshrc

# make colorful ls
echo 'eval "$(dircolors .dircolors)"' > test.txt

#install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
wget -P $ZSH_CUSTOM/plugins/zsh-web-search https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/web-search/web-search.plugin.zsh $ZSH_CUSTOM/plugins/zsh-web-search
wget -P $ZSH_CUSTOM/plugins/zsh-json-tools https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/jsontools/jsontools.plugin.zsh


# install utilities
sudo apt install -y curl ca-certificates gpg gnupg gnupg2 lsb-release software-properties-common apt-transport-https build-essential linux-headers-$(uname -r)
sudo apt install -y default-jdk

sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo mkdir -p /etc/apt/keyrings

cd $downloaddir

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo groupadd docker
sudo usermod -aG docker $USER

# Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
| sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Google Chrome
wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg 
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
| sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

# nvm (Node Js)
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

# Rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# Dbeaver
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg

# VS Code
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list

# IntelliJ IDEA
wget -O idea.tar.gz https://download.jetbrains.com/idea/ideaIC-2021.2.1.tar.gz
sudo mkdir /opt/idea/
echo "Наступна операція вимагає паролю користувача root"
su -c "cat configuration/environment >> /etc/environment" $(id -u -n 0)
sudo tar -zxf idea.tar.gz --directory /opt/idea/ --strip-components 1
sudo chmod 777 /opt/idea/
cd /opt/idea/bin/
cd $downloaddir
sudo cp configuration/intellijIdea.desktop /usr/share/applications

# Anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

# Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' \
| sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# PDF reader
wget http://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz
tar -xzf FoxitReader*.tar.gz
sudo chmod a+x FoxitReader*.run
sudo ./FoxitReader*.run


# Libre Office
flatpak install -y --noninteractive flathub org.libreoffice.LibreOffice

sudo apt update

sudo apt install -y google-chrome-stable docker-ce docker-ce-cli containerd.io docker-compose-plugin gh dbeaver-ce code anydesk signal-desktop \
  firefox-esr filezilla transmission-cli transmission-gtk gimp kcalc audacity vlc gucharmap gthumb obs-studio

cd $HOME
