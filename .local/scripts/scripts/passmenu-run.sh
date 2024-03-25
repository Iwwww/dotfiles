#!/usr/bin/env sh

# Load scheme colors
pywalcolors="${HOME}/.cache/wal/colors.sh"

if [ -f "$pywalcolors" ]; then
  . "${HOME}/.cache/wal/colors.sh"
    passmenu -l 10 -nf $color15 -nb $color0 -sb $color5 -sf $color0 -i
  else
    passmenu -l 10
fi
