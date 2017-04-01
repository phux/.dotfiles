source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found
antigen bundle tmuxinator
antigen bundle tmux
antigen bundle docker
antigen bundle docker-compose
antigen bundle gitfast

antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme simple

antigen apply






alias sdn='sudo shutdown now -h'
alias update='sudo apt-fast update && sudo apt-fast upgrade'
alias agi='sudo apt-fast install'
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias ob='observr autotest.rb'

alias mux='tmuxinator'



[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export TERM=xterm-256color


# disable c-s and c-q freeze
stty stop ''
stty start ''
stty -ixon
stty -ixoff

alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
alias gbd="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -U compinit && compinit

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export GOPATH="$HOME/go"
export LGOBIN="$HOME/go/bin"
PATH=$PATH:~/.config/composer/vendor/bin:~/bin:$LGOBIN
export NVIM_TUI_ENABLE_CURSOR_SHAPE=0
export TMP=/tmp
export TMPDIR=/tmp



PATH=/home/jm/.gvm/pkgsets/go1.8/global/bin:/home/jm/.gvm/gos/go1.8/bin:/home/jm/.gvm/pkgsets/go1.8/global/overlay/bin:/home/jm/.gvm/bin:/home/jm/.gvm/bin:/home/jm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/jm/.config/composer/vendor/bin:/home/jm/.gvm/gos/go1.8/bin:/home/jm/.fzf/bin:/home/jm/.config/composer/vendor/bin:/home/jm/bin:/home/jm/go/bin:~/.config/composer/vendor/bin
alias config='/usr/bin/git --git-dir=/home/jm/.cfg/ --work-tree=/home/jm'
