#!/bin/bash

# Check if networknig is enabled
if ! nmcli general status | grep -q "asleep"; then
    sufix=""

    # Check if ethernet is on
    if nmcli device status | grep "ethernet" | grep -q "connected"; then
        echo "󰈀 "
        sufix="|"
    fi

    # Check if wifi is on
    if  nmcli radio wifi | grep -q 'enabled'; then
        sufix="|"
        if nmcli connection show --active | grep -q 'wifi'; then
            nmcli connection show --active | grep 'wifi' | awk '{print "󰤨 " $1 " "}'
        else
            echo "󰤯 "
        fi
    fi

    echo $sufix
fi
