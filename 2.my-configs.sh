#!/bin/bash

mkdir -p $HOME/.config
mkdir -p $HOME/.background
mkdir -p $HOME/.icons
mv ./config/.Xresources $HOME/.Xresources
mv ./config/.Xdefaults $HOME/.Xdefaults
mv ./config/background.jpg $HOME/.background/background.jpg
cp -R config/* $HOME/.config/
