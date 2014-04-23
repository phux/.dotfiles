#!/bin/bash

DOTDIR="$HOME/.dotfiles"

echo 'linking i3 config'
ln -fs $DOTDIR/.i3/config $HOME/.i3/config

echo 'linking gtk files'
ln -fs $DOTDIR/.gtkrc-2.0 $HOME/.gtkrc-2.0
ln -fs $DOTDIR/settings.ini $HOME/.config/gtk-3.0/settings.ini

echo 'linking Xdefaults'
ln -fs $DOTDIR/.Xdefaults $HOME/.Xdefaults

echo 'linking ack config'
ln -fs $DOTDIR/.ackrc $HOME/.ackrc
