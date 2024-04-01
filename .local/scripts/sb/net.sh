#!/bin/bash

# Check if networknig is enabled
if ! nmcli general status | grep -q "asleep"; then
    sufix=""

    # Check if ethernet is on
    if nmcli device status | grep "ethernet" | grep -q "connected"; then
        printf "󰈀 "
        sufix="|"
    fi

    # Check if wifi is on
    if  nmcli radio wifi | grep -q 'enabled'; then
        if nmcli connection show --active | grep -q 'wifi'; then
            nmcli -g TYPE,NAME connection show --active | grep wireless | awk -F ':' '{print "󰤨 " $2 " "}'
        else
            printf "󰤯 "
        fi
        sufix="|"
    fi
    printf $sufix
fi
