#!/bin/bash

mkdir -p $HOME/.config
mkdir -p $HOME/.background
mkdir -p $HOME/.icons

cd configuration

mv .config/.Xresources $HOME/.Xresources
mv .config/.Xdefaults $HOME/.Xdefaults
mv .config/background.jpg $HOME/.background/background.jpg
cp -R .config/* $HOME/.config/

# load theme for sddm
sudo mkdir -p /usr/share/sddm/themes
sudo tar ‑xzf sugar‑candy-patched.tar.gz ‑C /usr/share/sddm/themes
sudo cp sddm.conf /etc/sddm.conf 


cd ..