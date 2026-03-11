#!/bin/bash

# ACTIVESYNC=$(pacmd list-sinks | grep \* | awk '{print $3}')
#ACTIVESYNC=3

case "$1" in
    raise)
         pactl set-sink-volume @DEFAULT_SINK@ +5%
         ;;
    lower)
         pactl set-sink-volume @DEFAULT_SINK@ -5%
         ;;

    mute)
         pactl set-sink-mute @DEFAULT_SINK@ toggle
         ;;
esac
