#!/bin/bash

xset r rate 300 35
setxkbmap -option caps:escape
# always pressing this menu key -> disable
xmodmap -e 'keycode 135='

# export TERM_BRIGHT='/tmp/term.bright'
# currenttime=$(date +%H:%M)
# if [[ "$currenttime" > "06:00" ]] || [[ "$currenttime" < "19:00" ]]; then
#     export BAT_THEME="GitHub"
#     xrdb -merge ~/.Xresources.papercolor
#     touch $TERM_BRIGHT
# else
#     export BAT_THEME="ansi-dark"
# fi

if ! urxvtc "$@"; then
  urxvtd -q -o -f
fi

tmux new-session -d -s def
tmuxinator start dotfiles --no-attach

sleep 3; autorandr --change

~/Downloads/activitywatch/aw-qt &

~/.config/i3/wp-changer.sh &

joplin-gui &

blueman-applet &

sleep 5; dropbox start -i

fluxgui &
