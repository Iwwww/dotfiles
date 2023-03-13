#!/bin/bash

if ! wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "[MUTED]"; then
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100 $3}')
    if [[ $vol > 100 ]]; then
        printf "墳 " 
    else
        printf "󱄠 " 
    fi
    echo $vol
else
    printf " 󰖁 "
fi
