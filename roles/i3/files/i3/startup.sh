#!/bin/sh

feh --bg-max /home/jm/Pictures/success.jpg

xrdb ~/.Xresources

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s local
xset r rate 300 35

setxkbmap -option ctrl:nocaps
