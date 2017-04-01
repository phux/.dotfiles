#!/bin/sh

feh --bg-fill /home/jm/Documents/your_computer_is_on.jpg

syndaemon -R -k -i 0.5 -d

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi
