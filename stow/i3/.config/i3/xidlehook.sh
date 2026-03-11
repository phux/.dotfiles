#!/bin/bash

# Kill existing xidlehook instances to avoid duplicates on i3 restart
pkill xidlehook

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 600 \
    'notify-send --urgency=low -t 2000 "LOCKING screen in 30 seconds"' \
    '' \
  --timer 30 \
    'sh ~/.config/i3/i3lock.sh' \
    ''
