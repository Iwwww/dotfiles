#!/bin/bash

BAT=$(cat /sys/class/power_supply/BAT1/capacity)
ICON=""

if [[ $(cat /sys/class/power_supply/ACAD/online) == 0 ]]; then 
    if [[ $BAT -gt 90 ]]; then
        ICON="󰁹"
    else if [[ $BAT -gt 70 ]]; then
        ICON="󰂀"
    else if [[ $BAT -gt 50 ]]; then
        ICON="󰁾"
    else if [[ $BAT -gt 30 ]]; then
        ICON="󰁼"
    else if [[ $BAT -gt 15 ]]; then
        ICON="󰁺"
    else
        ICON="󱃍"
    fi
    fi
    fi
    fi
    fi
fi

printf "$ICON "
echo  "$BAT%"
