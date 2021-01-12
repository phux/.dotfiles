#!/bin/zsh

# fnm -> needed for node -> needed for coc.nvim
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"

# nvim +OpenTodoNote
cd ~/Dropbox/1vimwiki
nvim $@
