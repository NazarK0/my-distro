# Debian-NazarK0
my Debian customizations inspired by [Chris Titus Tech](https://github.com/ChrisTitusTech/Debian-titus) repo
 
### Download Debian installer
Use the following Debian ISO as the base <https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/debian-11.5.0-amd64-DVD-1.iso.torrent/>


### Core packages
* [Xorg](https://www.x.org/wiki/) - an open source implementation of the X Window System
* [pulseaudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) - a sound server system for POSIX OSes
* [Xmenu](https://github.com/phillbush/xmenuv) - menu utility for X
* [ncpamixer](https://github.com/fulhax/ncpamixer) -  mixer for PulseAudio in console
* [feh](https://feh.finalrewind.org/) - a lightweight and powerful image viewer that can also be used to manage the desktop wallpaper
* [psmisc](https://packages.debian.org/en/sid/psmisc) - utilities that use the proc file system (fuser, killall, peekfd, pstree, prtstat)
* [picom](https://github.com/yshui/picom) - picom is a compositor for X, it add transparency
* [sxhkd](https://github.com/baskerville/sxhkd) - is an X daemon that reacts to input events by executing commands (hotkey manager)
* [Ly](https://github.com/fairyglade/ly) - a lightweight TUI (ncurses-like) display manager
* some Qt template modules: [libqt5svg5](https://packages.debian.org/en/sid/libqt5svg5), [qml-module-qtquick-controls](https://packages.debian.org/sid/qml-module-qtquick-controls), [qml-module-qtquick-controls2](https://packages.debian.org/sid/qml-module-qtquick-controls2)
* [tint2](https://github.com/o9000/tint2) - a simple panel/taskbar made for modern X window managers
* zip, unzip - for archive processing
* 

### Fonts
* Fontawesome 5 Free
* Fontawesome 6 Free

## Install steps

1. Run as ROOT, enter root login and password
```
apt install git
cd /usr
git clone https://github.com/Nazark0/my-distro.git
cd my-distro
./1.core-setup.sh
```