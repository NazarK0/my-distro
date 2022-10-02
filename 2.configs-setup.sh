#!/bin/bash

mkdir -p $HOME/.config
mkdir -p $HOME/.wallapappers
mkdir -p $HOME/.icons

cd configuration

cp .Xresources $HOME/
cp .Xdefaults $HOME/
cp -R .config/* $HOME/.config/

# load theme for sddm
sudo mkdir -p /usr/share/sddm/themes
sudo tar ‑xzf sugar‑candy-patched.tar.gz ‑C /usr/share/sddm/themes
sudo cp sddm.conf /etc/sddm.conf 

cd ..