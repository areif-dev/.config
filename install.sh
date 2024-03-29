#!/usr/bin/env bash 

cp alacritty/alacritty.toml $HOME/.config
cp bashrc/.bashrc $HOME
cp starship/starship.toml $HOME/.config

declare -a regular_dirs
regular_dirs=(
   atuin 
   dunst 
   nvim 
   rofi 
   sway 
   waybar
)

for dir in "${regular_dirs[@]}"; do
    cp -r $dir $HOME/.config
done
