# ~/.zshenv - Zsh Environment Variables

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# /etc/zsh/zshrc runs compinit before .zshrc extends fpath; sheldon runs compinit deferred instead
skip_global_compinit=1
