#!/bin/bash

if $(nmcli connection show | grep wireguard -q); then
    echo "wireguard is up"
else
    wgon
fi

/home/mikhail/NativeApps/ChatGPT-linux-x64/ChatGPT
