#!/bin/sh

xset r rate 300 35
setxkbmap -option caps:escape
# always pressing this menu key -> disable
xmodmap -e 'keycode 135='
