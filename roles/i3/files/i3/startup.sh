#!/bin/sh

feh --bg-max /home/jm/Pictures/success.jpg

syndaemon -R -k -i 0.5 -d

xrdb ~/.Xresources

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s local
 xset r rate 300 35
