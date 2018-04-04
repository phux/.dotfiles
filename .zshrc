PROMPT_LEAN_COLOR2=120

source ~/.zsh_plugins.sh

alias update_antibody='antibody bundle < ~/.zsh_plugins.txt  > ~/.zsh_plugins.sh'
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

export TERM=xterm-256color

# same colors as ag
export FZF_DEFAULT_COMMAND='rg --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'  --files --smart-case --hidden --follow --sort-files --glob "!.git/*"'

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH="$HOME/go"
export LGOBIN="$HOME/go/bin"
export FZF_BIN_PATH="$HOME/.fzf/bin"
export PATH=$PATH:~/bin:$LGOBIN:$FZF_BIN_PATH
export TMP=/tmp
export TMPDIR=/tmp

# Increase Bash history size. Allow 32³ entries; the default is 500.
HISTSIZE='32768';
HISTFILESIZE="${HISTSIZE}";
HISTFILE="$HOME/.zsh_history"
SAVEHIST=32768
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
alias update='sudo apt update && sudo apt upgrade'
alias agi='sudo apt install'
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias ob='observr autotest.rb'
alias ls="ls --color=auto"
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias grep='grep --color'

alias mux='tmuxinator'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# disable c-s and c-q freeze
stty stop ''
stty start ''
stty -ixon
stty -ixoff

# show branches ordered by last commit date
alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
# detailed view
alias gbd="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

alias gstash='git stash --include-untracked'
alias gst='git status'
alias ga='git add'
alias gc='git commit -v'
alias gb='git branch'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gfa='git fetch --all'
alias glum='git pull upstream master'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gl='git pull'
alias glog='git log --oneline --decorate --color --graph'
alias gm='git merge'
alias gp='git push'
alias gsta='git stash save'
alias gstaa='git stash apply'



alias canihazinterwebz='sudo dhclient -r;sudo dhclient &'
alias tw='mux shell'

setopt AUTO_CD
setopt AUTO_PUSHD PUSHD_TO_HOME
alias d='dirs -v'

setopt CORRECT

my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

function setgov ()
{
     for i in {0..7};
     do
         sudo cpufreq-set -c $i -g $1; 
     done
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}


# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
gbf() {
  local branches branch
  branches=$(git for-each-ref --count=90 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

bindkey -e
PATH=/home/jm/.gvm/bin:/home/jm/.cargo/bin:/home/jm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/jm/.composer/vendor/bin:/home/jm/go/bin:/home/jm/.fzf/bin:/home/jm/.gvm/gos/go1.10/bin

alias sukablyad='sudo'
alias fucking=sudo

alias behat='dce php vendor/bin/behat'
alias "vendor/bin/behat"="dce php vendor/bin/behat"

# http://www.drbunsen.org/vim-croquet/ analysing
# alias nvim='nvim -w ~/.nvim_keylog "$@"'

alias n='nvim'
alias s='sudo'
alias c='composer'
alias ci='composer install'
alias cu='composer update'

alias upn='cd ~/compiles/neovim; git pull; make clean; make CMAKE_BUILD_TYPE=Release;sudo make install'

alias airtame='/opt/airtame-application/launch-airtame.sh'

alias efg='exercism fetch go'
alias es='exercism submit'
alias eg='cd $HOME/exercism/go/$(ls -t $HOME/exercism/go/ | head -1)'
alias gtb='go test -bench .'

alias ez='n ~/.zshrc'

source ~/gruvbox.sh
