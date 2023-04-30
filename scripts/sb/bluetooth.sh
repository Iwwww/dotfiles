#!/bin/bash

# Checks if bluetooth controller is powered on
power_on() {
    if bluetoothctl show | grep -F -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

# Checks if a device is connected
device_connected() {
    device_info=$(bluetoothctl info "$1")
    if printf "$device_info" | grep -F -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

if power_on; then
    # Human-readable names of devices, one per line
    # If scan is off, will only list paired devices
    devices=$(bluetoothctl devices | grep -F Device)

    # Separate with next line in for loop
    IFS=$'\n'
    for d in $devices; do
        # Get device name and mac address
        device_name="$(printf "$d" | cut -d ' ' -f 3-)"
        mac="$(printf "$d" | cut -d ' ' -f 2)"

        # Add connected devices to status
        if device_connected "$mac"; then
            status=$(printf "$status  $device_name ")
        fi
    done

    if [[ "$status" == "" ]]; then
        printf "  on "
    fi
    printf "$status|"
# else
#     printf ""
fi
