#!/bin/bash
#
# Manages audio keys on keyboard in i3 wm and launches volnoti window

## Add the following to your i3 config file:
##
## # Media, sound, audio keys
## bindsym XF86AudioRaiseVolume exec ~/.i3/i3audio.sh inc
## bindsym XF86AudioLowerVolume exec ~/.i3/i3audio.sh dec
## bindsym XF86AudioMute exec ~/.i3/i3audio.sh mute
## exec --no-startup-id volnoti


#### Set variables

AMIXER_CARD="0"
VOL_INCREMENT="3%"

################

function unmute {
    # Unmute all pulseaudio sinks
    for sink in $(pacmd list-sinks | grep -oE 'index: [0-9]+' | awk '{ print $2 }'); do
        pacmd set-sink-mute $sink 0
    done
}

AMIXER="amixer --card $AMIXER_CARD -q set Master"
case "$1" in
    inc)
        $AMIXER ${VOL_INCREMENT}+
        unmute
        ;;
    dec)
        $AMIXER ${VOL_INCREMENT}-
        unmute
        ;;
    mute) 
       pactl set-sink-mute $AMIXER_CARD toggle 
       ;;
    *)
        echo "Usage: $0 {inc|dec|mute}"
        exit 1
esac

# Get current volume
CURR_VOL=$(amixer -c1 get Master | grep -oE '([[:digit:]]+)%' | cut -d'%' -f1)

# Get mute status
amixer --card $AMIXER_CARD get Master | grep '\[off\]'
if [[ $? -eq 0 ]]; then
    MUTE_OPT="-m"
else
    MUTE_OPT=""
fi
