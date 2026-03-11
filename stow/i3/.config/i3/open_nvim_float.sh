#!/bin/zsh


# nvim +OpenTodoNote
if [[ "$1" == *"todo.txt"* ]]; then
    cd ~/Dropbox/todo
    nvim $@
elif [[ "$1" == *"wiki"* ]];then
    cd ~/Dropbox/1vimwiki
    nvim $@
elif [[ "$1" == *"org"* ]];then
    cd ~/Dropbox/org && nvim -c "lua require('orgmode').action('capture.prompt')"
else
    cd ~/Dropbox/
    nvim $@
fi
