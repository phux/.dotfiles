#!/bin/bash

xset r rate 300 35
setxkbmap -option caps:escape
# always pressing this menu key -> disable
xmodmap -e 'keycode 135='

# if ! urxvtc "$@"; then
#   urxvtd -q -o -f
# fi

tmux new-session -d -s def
tmuxinator start dotfiles --no-attach

sleep 3; autorandr --change

~/Downloads/activitywatch/aw-qt &

~/.config/i3/wp-changer.sh &

joplin-gui &

blueman-applet &

sleep 5; dropbox start -i

fluxgui &
