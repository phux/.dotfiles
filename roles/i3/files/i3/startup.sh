#!/bin/bash

# if ! urxvtc "$@"; then
#   urxvtd -q -o -f
# fi

~/.config/i3/wp-changer.sh &

# source ~/.dotfiles/roles/i3/files/i3/keyboard.sh &

sleep 5; dropbox start -i &

fluxgui &

~/Downloads/activitywatch/aw-qt &

tmux new-session -d -s def &
tmuxinator start dotfiles --no-attach &

blueman-applet &
