#!/bin/sh

xset r rate 300 35

setxkbmap -option caps:escape

feh --bg-center ~/Pictures/happy_face.jpg --image-bg #383f4e

xrdb ~/.Xresources

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s def
tmuxinator start dotfiles --no-attach

sleep 1; autorandr --change

sleep 5; dropbox start -i
