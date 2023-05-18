#!/bin/bash

# Loads new configs from my default path

# cp --backup=numbered -v "dunst/dunstrc" "dunst/dunstrc.bak"
# cp -v "$HOME/.config/dunst/dunstrc" "dunst/dunstrc"
#
# cp --backup=numbered -v "picom/picom.conf" "picom/picom.conf.bak"
# cp -v "$HOME/.config/picom/picom.conf" "picom/picom.conf"
#
# cp -rv --backup "$HOME/.config/lf/" "."

cp -rv "$HOME/.config/nvim/" "."
cp -rv "$HOME/.config/lf/" "."
