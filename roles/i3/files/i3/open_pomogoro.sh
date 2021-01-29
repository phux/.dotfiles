#!/bin/zsh

source ~/.config/zsh/.zshrc

if [ $(ps h -C "pomogoro" | wc -l) = 0 ]; then
    printf '\033];%s\a' "pomogoro_cli";
    pomogoro --config ~/.pomogoro.toml
fi

i3-msg scratchpad show
# i3-msg [title="pomogoro_cli"] scratchpad show
