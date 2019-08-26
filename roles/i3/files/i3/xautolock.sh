#!/bin/bash

# got this from: http://rabexc.org/posts/awesome-xautolock-battery
# add -d to i3lock to set screen to standby directly
TIME_TO_SLEEP=10

exec xautolock -detectsleep -time 3 -locker "sh ~/.i3/i3lock.sh" -notify $TIME_TO_SLEEP -notifier "notify-send --urgency=critical -t 10000 'LOCKING screen in $TIME_TO_SLEEP seconds'" -corners ---- -cornersize 30
