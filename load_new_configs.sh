#!/bin/bash

# Loads new configs from my default path

i3ConfigNewFile="$HOME/.i3/config"
i3ConfigOldFile="$HOME/Documents/i3-sway-config/i3/config"

cp --backup=numbered "$i3ConfigOldFile" "i3/config.bak"
cp "$i3ConfigNewFile" "$i3ConfigOldFile"

cp --backup=numbered "dunst/dunstrc" "dunst/dunstrc.bak"
cp "$HOME/.config/dunst/dunstrc" "dunst/dunstrc"

cp --backup=numbered -v "picom/picom.conf" "picom/picom.conf.bak"
cp -v "$HOME/.config/picom.conf" "picom/picom.conf"
