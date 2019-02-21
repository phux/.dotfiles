WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

source ~/.profile
export PURE_PROMPT_PATH_FORMATTING="%~"
export NVM_LAZY_LOAD=true

if [ -f $XDG_CONFIG_HOME/zsh/cached_plugins.sh ]; then
    source $XDG_CONFIG_HOME/zsh/cached_plugins.sh
fi

export EDITOR="nvim"
export TERM=xterm-256color
export TODOTXT_DEFAULT_ACTION=ls
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# same colors as ag
export FZF_DEFAULT_COMMAND='rg --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'  --files --smart-case --hidden --follow --sort-files --glob "!.git/*"'


[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH="$HOME/code/go"
export LGOBIN="$HOME/code/go/bin"
export FZF_BIN_PATH="$HOME/.fzf/bin"

HISTSIZE='100000';
HISTFILESIZE="${HISTSIZE}";
HISTFILE="$HOME/.zsh_history"
SAVEHIST=32768
HISTDUP=erase
setopt appendhistory             #Append history to the history file (no overwriting)
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt CORRECT
setopt AUTO_CD
setopt AUTO_PUSHD PUSHD_TO_HOME
# setopt interactivecomments

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

alias update_antibody="antibody bundle < $XDG_CONFIG_HOME/zsh/antibody_plugins.txt  > $XDG_CONFIG_HOME/zsh/cached_plugins.sh; antibody update"

alias sdn='sudo shutdown now -h'
alias update='sudo apt-fast update && sudo apt-fast upgrade; update_antibody; n +PU'
alias agi='sudo apt-fast install'

alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias vp='vagrant provision'

alias dcup='docker-compose up'
alias dcstop='docker-compose stop'
alias dcdn='docker-compose down'
alias dce='docker-compose exec'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'

alias ob='observr autotest.rb'

alias ls="ls --color=auto"
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ll='ls -l'      #long list

alias grep='grep --color'


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
alias grp='git reset HEAD~'
alias gca='git commit -v --amend'
alias gb='git branch'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gfa='git fetch --all'
alias glum='git pull upstream master'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gbb='git branch bkp_$(git_current_branch)_$(date +"%Y-%m-%d_%H-%M-%S") $(git_current_branch)'
alias gl='git pull'
alias glog='git log --oneline --decorate --color --graph'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gm='git merge'
alias gp='git push'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gfi='git fixup HEAD^'


alias gbi='git branch -D $(git_current_branch)-integration;git branch $(git_current_branch)-integration $(git_current_branch)'
alias gpi='git push $(git_current_branch)-integration'
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

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


gbf() {
  local branches branch
  branches=$(git for-each-ref --count=90 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches") |
    fzf-tmux -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
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

# http://www.drbunsen.org/vim-croquet/ analysing
# alias nvim='nvim -w ~/.nvim_keylog "$@"'


alias n='nvim'
alias c='composer'
alias ci='composer install --no-progress --prefer-dist --profile'
alias cu='composer update --no-progress --prefer-dist --profile'

alias efg='exercism download --track=go'
alias es='exercism submit'
alias eg='cd $HOME/code/exercism/go/$(ls -t $HOME/code/exercism/go/ | head -1)'
alias gtb='go test -bench .'
alias gt='richgo test ./...'

alias ez='n ~/.zshrc;source ~/.zshrc'
alias .d='cd ~/.dotfiles'
alias ma='make'
alias mt='make test'
alias idea='~/tools/idea-IC-182.3684.101/bin/idea.sh'

# source ~/.gruvbox.sh

export ANSIBLE_NOCOWS=1

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f ~/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . ~/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f ~/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . ~/.nvm/versions/node/v8.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

_tmuxinator() {
  local commands projects
  commands=(${(f)"$(tmuxinator commands zsh)"})
  projects=(${(f)"$(tmuxinator completions start)"})

  if (( CURRENT == 2 )); then
    _alternative \
      'commands:: _describe -t commands "tmuxinator subcommands" commands' \
      'projects:: _describe -t projects "tmuxinator projects" projects'
  elif (( CURRENT == 3)); then
    case $words[2] in
      copy|debug|delete|open|start)
        _arguments '*:projects:($projects)'
      ;;
    esac
  fi

  return
}

compdef _tmuxinator tmuxinator mux

alias m='~/.tmux/mux.sh'
alias mux='tmuxinator'

alias gw="JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ./gradlew"

alias tm='todotxt-machine'
alias tn='n ~/Dropbox/todo/work/todo.txt'
alias tnn='n ~/Dropbox/todo/todo.txt'
alias nn='n +RecentNotes'

function zd() {
    file="/tmp/base_$(date '+%H%M%S').json"
  echo $1 | sed -r 's/\\\\r\\\\n//g' | base64 -d | zlib -d > $file;n $file
  echo "n $file"
}

fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

if [ -f $XDG_CONFIG_HOME/zsh/notifyosd.zsh ]; then
    source $XDG_CONFIG_HOME/zsh/notifyosd.zsh
fi

# Automate ssh-agent startup
if [ -z "$SSH_AUTH_SOCK" ] ; then
 eval `ssh-agent -s`
 ssh-add
fi

if [ -f ~/.secret_aliases ]; then
    source ~/.secret_aliases
fi
# TODO: screws up ansible
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$IS_ANSIBLE" && test -z "$TMUX" && (tmux attach-session -t def || tmux new-session -s def)
fi

# Vi mode
 bindkey -v

# http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '\e.' insert-last-word

bindkey '^R' fzf-history-widget

zle -N edit-command-line
# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# maps jk to escape, same as in my init.vim
# bindkey -m viins 'jk' vi-cmd-mode
bindkey 'jk' vi-cmd-mode

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.composer/vendor/bin:$FZF_BIN_PATH:$LGOBIN:$HOME/.config/composer/vendor/bin
