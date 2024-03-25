#!/bin/bash

# Check if networknig is enabled
if ! nmcli general status | grep -q "asleep"; then
    sufix=""

    # Check if vpn is on
    if nmcli device status | grep "wireguard" -q; then
        # printf "VPN"
        printf "󰌆"
        sufix=""
    fi

    printf " %s " $sufix
fi
