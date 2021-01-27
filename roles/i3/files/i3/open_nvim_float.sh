#!/bin/zsh

# fnm -> needed for node -> needed for coc.nvim
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"

# nvim +OpenTodoNote
if [[ "$1" == *"todo.txt"* ]]; then
    cd ~/Dropbox/todo
elif [[ "$1" == *"wiki"* ]];then
    cd ~/Dropbox/1vimwiki
else
    cd ~/Dropbox/
fi
ls
nvim $@
