#!/bin/bash

# Loads new configs from my default path

i3ConfigNewFile="$HOME/.i3/config"
i3ConfigOldFile="$HOME/Documents/i3-sway-config/i3/config"

cp --backup=numbered "$i3ConfigOldFile" "i3/config.bak"
cp "$i3ConfigNewFile" "$i3ConfigOldFile"
