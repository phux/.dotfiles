#!/bin/bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  --not-when-fullscreen \
  --timer 90 \
    'notify-send --urgency=low -t 2000 "LOCKING screen in 10 seconds"' \
    '' \
  --timer 10 \
    'sh ~/.config/i3/i3lock.sh' \
    ''
