#!/bin/sh

xset r rate 300 35

setxkbmap -option ctrl:nocaps

feh --bg-max /home/janmolowitz/Pictures/gesundheit.jpg

xrdb ~/.Xresources

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s local

dropbox start
