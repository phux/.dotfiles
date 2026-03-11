#!/bin/bash

case "$1" in
    raise)
         wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
         ;;
    lower)
         wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
         ;;

    mute)
         wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
         ;;
esac