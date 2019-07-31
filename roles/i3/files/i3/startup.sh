#!/bin/sh

xset r rate 300 35

setxkbmap -option caps:escape

~/.i3/wp-changer.sh &

xrdb ~/.Xresources

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s def
tmuxinator start dotfiles --no-attach

sleep 1; autorandr --change
sleep 1; Joplin-1.0.160-x86_64.AppImage &


sleep 5; dropbox start -i
