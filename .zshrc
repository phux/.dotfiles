ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc)
source ~/.zplug/init.zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/gitfast",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
zplug "plugins/tmuxinator",   from:oh-my-zsh
zplug "themes/simple",   from:oh-my-zsh, as:theme
# zplug "mafredri/zsh-async", from:github, defer:0
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplug "djui/alias-tips"

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf
zplug "zsh-users/zsh-completions"


# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

export EDITOR=nvim
export TERM=xterm-256color

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export GOPATH="$HOME/go"
export LGOBIN="$HOME/go/bin"
PATH=$PATH:~/.config/composer/vendor/bin:~/bin:$LGOBIN
export NVIM_TUI_ENABLE_CURSOR_SHAPE=0
export TMP=/tmp
export TMPDIR=/tmp

# Increase Bash history size. Allow 32³ entries; the default is 500.
HISTSIZE='32768';
HISTFILESIZE="${HISTSIZE}";
HISTFILE="$HOME/.zsh_history"
SAVEHIST=5000
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

alias sdn='sudo shutdown now -h'
alias update='sudo apt-fast update && sudo apt-fast upgrade'
alias agi='sudo apt-fast install'
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias ob='observr autotest.rb'

alias mux='tmuxinator'
# Just fun
alias fucking=sudo

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -U compinit && compinit

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# disable c-s and c-q freeze
stty stop ''
stty start ''
stty -ixon
stty -ixoff

alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
alias gbd="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"


PATH=/home/jm/.gvm/pkgsets/go1.8/global/bin:/home/jm/.gvm/gos/go1.8/bin:/home/jm/.gvm/pkgsets/go1.8/global/overlay/bin:/home/jm/.gvm/bin:/home/jm/.gvm/bin:/home/jm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/jm/.composer/vendor/bin:/home/jm/.fzf/bin

alias canihazinterwebz='sudo dhclient -r;sudo dhclient &'

setopt auto_cd
setopt autopushd
