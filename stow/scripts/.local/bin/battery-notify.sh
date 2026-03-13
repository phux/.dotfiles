#!/bin/bash

# Configuration
LOW_THRESHOLD=10
CRITICAL_THRESHOLD=5
CHECK_INTERVAL=60 # seconds

# State tracking to avoid spamming
NOTIFIED_LOW=false
NOTIFIED_CRITICAL=false

while true; do
    if [ -d /sys/class/power_supply/BAT0 ]; then
        CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
        STATUS=$(cat /sys/class/power_supply/BAT0/status)

        if [ "$STATUS" = "Discharging" ]; then
            if [ "$CAPACITY" -le "$CRITICAL_THRESHOLD" ]; then
                if [ "$NOTIFIED_CRITICAL" = false ]; then
                    notify-send -u critical "Battery Critical" "Battery level is at ${CAPACITY}%!"
                    NOTIFIED_CRITICAL=true
                fi
            elif [ "$CAPACITY" -le "$LOW_THRESHOLD" ]; then
                if [ "$NOTIFIED_LOW" = false ]; then
                    notify-send -u normal "Battery Low" "Battery level is at ${CAPACITY}%"
                    NOTIFIED_LOW=true
                fi
            fi
        else
            # Reset notifications when charging
            NOTIFIED_LOW=false
            NOTIFIED_CRITICAL=false
        fi
    fi
    sleep "$CHECK_INTERVAL"
done
