#!/bin/bash

downloaddir=/distro-src/download
logfile=/distro-src/distro-install.log

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
source ~/.bashrc

nvm install node --lts 
nvm install node 

# Rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# Dbeaver
echo "deb https://dbeaver.io/debs/dbeaver-ce/" | sudo tee /etc/apt/sources.list.d/dbeaver.list > /dev/null
curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg

# VS Code
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list

# IntelliJ IDEA
wget https://download.jetbrains.com/idea/ideaIC-2021.2.1.tar.gz
tar -zxf ideaIC-*.tar.gz ‑C IntellijIDEA
sudo mkdir /opt/idea/
sudo chmod 777 /opt/idea/
cd IntellijIDEA
mv idea-*/* /opt/idea/
cd /opt/idea/bin/
sh idea.sh
cd $downloaddir

# VMware Player
wget -P $downloaddir https://www.vmware.com/go/getplayer-linux 
cd VMwarePlayer
chmod +x VMware-Player-Full-*.bundle
sudo ./VMware-Player-Full-*.bundle
cd $downloaddir

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
  firefox-esr filezilla transmission-cli transmission gimp kcalc audacity

cd $HOME
