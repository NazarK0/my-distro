# Debian-NazarK0
my Debian customizations inspired by [Chris Titus Tech](https://github.com/ChrisTitusTech/Debian-titus) repo
 
### Download Debian installer
Use the following Debian ISO as the base <https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/debian-11.5.0-amd64-DVD-1.iso.torrent/>


### Core packages
* [pulseaudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) - a sound server system for POSIX OSes
* [Xmenu](https://github.com/phillbush/xmenuv) - menu utility for X
* [ncpamixer](https://github.com/fulhax/ncpamixer) -  mixer for PulseAudio in console
* [feh](https://feh.finalrewind.org/) - a lightweight and powerful image viewer that can also be used to manage the desktop wallpaper
* [psmisc](https://packages.debian.org/en/sid/psmisc) - utilities that use the proc file system (fuser, killall, peekfd, pstree, prtstat)
* [picom](https://github.com/yshui/picom) - picom is a compositor for X, it add transparency
* [sxhkd](https://github.com/baskerville/sxhkd) - is an X daemon that reacts to input events by executing commands (hotkey manager)
* [sddm](https://github.com/sddm/sddm) - a modern display manager for X11 and Wayland
* some Qt template modules: [libqt5svg5](https://packages.debian.org/en/sid/libqt5svg5), [qml-module-qtquick-controls](https://packages.debian.org/sid/qml-module-qtquick-controls), [qml-module-qtquick-controls2](https://packages.debian.org/sid/qml-module-qtquick-controls2)
* [tint2](https://github.com/o9000/tint2) - a simple panel/taskbar made for modern X window managers
* [bspwm](https://github.com/baskerville/bspwm) - a tiling window manager that represents windows as the leaves of a full binary tree
* zip, unzip - for archive processing
* [kitty](https://sw.kovidgoyal.net/kitty) - The fast, feature-rich, GPU based terminal emulator

### Fonts
* Fontawesome 4 Free
* Fontawesome 5 Free
* Fontawesome 6 Free
* [Powerline batch fonts](https://github.com/powerline/fonts)
* [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/releases/)
* emoji font
* fonts from powerline

### Icons
* [icons8](https://icons8.com)

### Apps
* Google Chrome
* Firefox
* Docker
* Github CLI
* nvm (Node Js)
* Rust
* Dbeaver
* VS Code
* Intellij IDEA
* VMPware Player
* Anydesk
* Signal
* Libre Office
* FoxitReader
* Filezilla
* Transmission
* Gimp
* Kcalc
* Audacity

## Install steps

1. Run as ROOT, enter root login and password
```
apt install git
mkdir /distro-src
cd /distro-src
git clone https://github.com/Nazark0/my-distro.git
cd my-distro
./1.core-setup.sh
```
2. Reboot your system. By this moment you will have bare minimum distro. If you want copy my settings and apps, run 2nd and 3rd script.
3. Login into system by your account and do next:
```
cd /distro-src/my-distro
./2.cofigs-setup.sh
```
4. When done, run last script:
```
./3.install-apps.sh
```