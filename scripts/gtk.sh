#!/usr/bin/env bash

rm -rf $HOME/.config/gtk-*

cd $HOME/.config
wget https://github.com/catppuccin/gtk/releases/latest/download/Catppuccin-Mocha-Standard-Mauve-Dark.zip

unzip $HOME/.config/Catppuccin-Mocha-Standard-Mauve-Dark.zip

mv $HOME/.config/Catppuccin-Mocha-Standard-Mauve-Dark/gtk-* $HOME/.config
rm -rf $HOME/.config/Catppuccin-Mocha-Standard-Mauve-Dark*
