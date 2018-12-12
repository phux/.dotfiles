#!/bin/sh

xset r rate 300 35

setxkbmap -option ctrl:nocaps

feh --bg-center ~/Pictures/happy_face.jpg --image-bg #383f4e

xrdb ~/.Xresources

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s local

dropbox start

sleep 1; autorandr --change
