#!/bin/bash
if test -f "$TERM_BRIGHT"; then
    xrdb ~/.Xresources
    rm "$TERM_BRIGHT"
else
    xrdb -merge ~/.gruvbox-light.Xresources
    touch "$TERM_BRIGHT"
fi
