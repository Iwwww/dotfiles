#!/bin/bash

rm .local

mkdir -p .config

cp -rv "$HOME/.config/nvim" ".config/"
cp -rv "$HOME/.config/lf" ".config/"
cp -rv "$HOME/.config/mpv" ".config/"
cp -rv "$HOME/.config/fish" ".config/"
cp -rv "$HOME/.config/dunst" ".config/"
cp -rv "$HOME/.config/i3" ".config/"
cp -rv "$HOME/.config/wal" ".config/"
cp -rv "$HOME/.config/zathura" ".config/"
cp -rv "$HOME/.config/mimeapps.list" ".config/"
cp -rv "$HOME/.config/waybar" ".config/"

cp -rv "$HOME/.startup" "."

mkdir -p .local/scripts
mkdir -p .local/bin

cp -rv "$HOME/.local/scripts" ".local/"
cp -rv "$HOME/.local/bin/lfub" ".local/bin"

