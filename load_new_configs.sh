#!/bin/bash

# Loads new configs from my default path

i3ConfigNewFile="$HOME/.i3/config"
i3ConfigOldFile="$HOME/Documents/i3-sway-config/i3/config"

if diff -s "$i3ConfigNewFile" "$i3ConfigOldFile"; then
    printf 'The file "%s" is the same as "%s"\n' "$i3ConfigNewFile" "$i3ConfigOldFile"
else
    printf 'Backup old file and copy new to a new file\n'
    #mv -b "$i3ConfigOldFile" "$i3ConfigOldFile"
    cp -b $i3ConfigNewFile $i3ConfigOldFile
fi

