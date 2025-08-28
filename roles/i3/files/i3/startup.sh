#!/bin/bash

autorandr --change

obsidian &

chromium-browser &

urxvtcd -q -o -f

# ~/.config/i3/wp-changer.sh &


# sleep 5; dropbox start -i &

# fluxgui &

# tmux new-session -d -s def &
# tmuxinator start dotfiles --no-attach &
# tmuxinator start todo --no-attach &

blueman-applet &

xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0

~/.dotfiles/roles/i3/files/i3/keyboard.sh &

~/Downloads/activitywatch/aw-qt &
