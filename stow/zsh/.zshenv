# ~/.zshenv - Zsh Environment Variables

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Path additions
export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# FNM (Fast Node Manager)
export PATH="$HOME/.local/share/fnm:$PATH"
if command -v fnm 1>/dev/null 2>&1; then
  eval "$(fnm env)"
fi

# Sheldon plugin manager
if command -v sheldon 1>/dev/null 2>&1; then
  eval "$(sheldon source)"
fi
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
