#!/bin/sh

syndaemon -R -k -i 0.5 -d

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi
