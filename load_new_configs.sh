#!/bin/bash

# Loads new configs from my default path

i3ConfigNewFile="$HOME/.i3/config"
i3ConfigOldFile="$HOME/Documents/i3-sway-config/i3/config"

cp --backup=numbered -v "$i3ConfigOldFile" "i3/config.bak"
cp -v "$i3ConfigNewFile" "$i3ConfigOldFile"

cp --backup=numbered -v "dunst/dunstrc" "dunst/dunstrc.bak"
cp -v "$HOME/.config/dunst/dunstrc" "dunst/dunstrc"

cp --backup=numbered -v "picom/picom.conf" "picom/picom.conf.bak"
cp -v "$HOME/.config/picom.conf" "picom/picom.conf"

cp -rv --backup "$HOME/.config/lf/" "."

cp -rv --backup "$HOME/.config/nvim/" "."
