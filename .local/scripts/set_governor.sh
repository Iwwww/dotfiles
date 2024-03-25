#! /bin/bash

# Set governor
for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "$1" > $file; done
