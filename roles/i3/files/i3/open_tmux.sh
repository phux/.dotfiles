#!/bin/zsh

source ~/.config/zsh/.zshrc

tmuxinator start $1 --suppress-tmux-version-warning=SUPPRESS-TMUX-VERSION-WARNING

# tmux has-session -t $1 2>/dev/null
# if [ "$?" -eq 1 ] ; then
# 	tmuxinator start $1 --suppress-tmux-version-warning=SUPPRESS-TMUX-VERSION-WARNING
# fi

# tmux attach-session -t $1
