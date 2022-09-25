# Debian-titus
Debian customizations from Nazar Vanivskyi, based on [Chris Titus Tech](https://github.com/ChrisTitusTech/Debian-titus) repo
 
### Download Debian non-free netinstall

Use the following Debian ISO as the base <https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/weekly-builds/amd64/iso-cd/>

*do NOT grab the EDU download and this includes non-free and firmware*
### Base Stuff - Root

_Run as ROOT, enter root login and password
```
apt install git
cd /tmp
git clone https://github.com/Nazark0/my-distro.git
cd my-distro
./1.root-setup.sh
./2.0.user-setup.sh
sudo reboot
./2.1.user-setup.sh
```