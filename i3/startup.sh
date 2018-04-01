#!/bin/sh

feh --bg-max /home/jm/Pictures/success.jpg

syndaemon -R -k -i 0.5 -d

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi
