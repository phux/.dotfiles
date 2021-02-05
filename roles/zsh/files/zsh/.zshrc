# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# start tracing
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
# setopt XTRACE
# zmodload zsh/zprof
# end tracing

export TERM=st-256color


# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!.git/" -g "!node_modules" -g "!/*/vendor/*" -g "!vendor/*" -g "!*.neon" -g "!composer.lock" -g "!*/var/*" -g "!var/*" -g "!*/cache/*"  2> /dev/null'

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude node_modules --exclude vendor --exclude var'

# export SKIM_DEFAULT_COMMAND="fd --type f --hidden || git ls-tree -r --name-only HEAD || rg --files || find ."
# export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
# export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_BIN_PATH="$HOME/.fzf/bin"

WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

export SHOW_AWS_PROMPT=false
export PURE_PROMPT_PATH_FORMATTING="%~"

# if [ -f $XDG_CONFIG_HOME/zsh/cached_plugins.sh ]; then
    # source $XDG_CONFIG_HOME/zsh/cached_plugins.sh
# fi
export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export GOPATH="$HOME/code/go"
export LGOBIN="$HOME/code/go/bin"
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.composer/vendor/bin:$FZF_BIN_PATH:$LGOBIN:$HOME/.config/composer/vendor/bin:$HOME/.config/nvim/plugged/phpactor/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/.cargo/bin/:$HOME/tools/git-fuzzy/bin

HISTSIZE='100000';
HISTFILESIZE="${HISTSIZE}";
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=32768
HISTDUP=erase
# Report command running time if it is more than 3 seconds
REPORTTIME=3
setopt appendhistory             # Append history to the history file (no overwriting)
setopt always_to_end             # when completing from the middle of a word, move the cursor to the end of the word
setopt chase_links               # resolve symlinks
setopt complete_in_word          # allow completion from within a word/phrase
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
setopt CORRECT
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
# setopt interactivecomments

export TERM_BRIGHT='/tmp/term.bright'

export WIKI_DIR='~/Dropbox/1vimwiki/'
export NEXTWORD_DATA_PATH=~/tools/nextword-data/nextword-data-large

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.

alias update_antibody="antibody bundle < $XDG_CONFIG_HOME/zsh/antibody_plugins.txt  > $XDG_CONFIG_HOME/zsh/cached_plugins.sh; antibody update"

alias sdn='sudo shutdown now -h'
alias update="sudo apt update && sudo apt upgrade -y && .d && git pull && make provision;nvim +PackerUpdate +PackerCompile +CocUpdate"
alias agi='sudo apt-fast install'

alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias vp='vagrant provision'

alias dcup='docker-compose up'
alias dcps='docker-compose ps'
alias dcr='docker-compose restart'
alias dcstop='docker-compose stop'
alias dcdn='docker-compose down -v --remove-orphans'
alias dce='docker-compose exec'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'

# alias tf='terraform'
alias tfw='terraform workspace'

alias ob='observr observer.rb'

alias ls="ls --color=auto"
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ll='ls -l'      #long list

alias grep='grep --color'

alias cat='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPAGER="nvim -c 'set ft=man' -"

# disable c-s and c-q freeze
# stty stop ''
# stty start ''
# stty -ixon
# stty -ixoff

# show branches ordered by last commit date
alias gb="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
# detailed view
alias gbd="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

alias gst='git status'
# alias gs='n +Gstatus'
export GF_LOG_MENU_PARAMS='--pretty="%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --topo-order'
export GF_PREFERRED_PAGER="delta --theme=gruvbox --highlight-removed -w __WIDTH__"

export GIT_FUZZY_STATUS_COMMIT_KEY="Alt-H"
export GIT_FUZZY_BRANCH_CHECKOUT_KEY="Alt-H"
# when diffing with branches or commits for preview
export GF_DIFF_COMMIT_PREVIEW_DEFAULTS="--patch-with-stat"

# when diffing with branches or commits for preview
export GF_DIFF_COMMIT_RANGE_PREVIEW_DEFAULTS="--summary"

# when diffing individual files
export GF_DIFF_FILE_PREVIEW_DEFAULTS="--indent-heuristic"

gch() {
	git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | fzf | xargs git checkout
}
alias gs='git fuzzy status'
alias gdt='n +"Git difftool -y"'
alias glog='n +GV'
alias b='git fuzzy branch'
alias gdh='n +"Git! difftool"'
alias gmt='n +"Git mergetool"'
alias gdm='n +"Gdiff $(git merge-base master HEAD)"'

alias ga='git add'
alias gc='git commit -v'
alias grh='git reset HEAD'
alias guc='git reset HEAD~'
alias gca='git commit -v --amend'
alias gb='git branch'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gfa='git fetch --all'
alias glum='git pull upstream master'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gbb='git branch bkp_$(git_current_branch)_$(date +"%Y-%m-%d_%H-%M-%S") $(git_current_branch)'
alias gl='git pull'
# alias glog="git log --graph --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glp="git log --first-parent --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glm="git log --first-parent --merges --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gm='git merge -X histogram'
alias gmp='git merge -X patience'
alias gmd='git merge'
alias gp='git push'
alias grp='git rebase -i @{u}'
alias gr='git rebase'
alias gss='git stash save'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gsu='git stash --include-untracked'
alias gsa='git stash apply'
alias gfi='git fixup HEAD^'
alias grc='git diff --name-only | uniq | xargs $EDITOR'
alias gclean='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'

alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

fpath=($fpath ~/.dotfiles/roles/zsh/files/autoloaded)
autoload fo
autoload git_current_branch
autoload custom-backward-delete-word
autoload zn
# autoload td
zle -N custom-backward-delete-word
bindkey '^W' custom-backward-delete-word

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR

bindkey -e

# http://www.drbunsen.org/vim-croquet/ analysing
alias nl='nvim -w ~/.nvim_keylog "$@"'

alias n='~/tools/neovim/build/bin/nvim -w ~/.nvim_keylog "$@"'
alias nd='cd ~/.dotfiles/roles/neovim/; n files/conf/init.lua'
alias c='composer'
alias ci='composer install --no-progress --prefer-dist --profile'
alias cu='composer update --no-progress --prefer-dist --profile'

alias efg='exercism download --track=go'
alias es='exercism submit'
alias eg='cd $HOME/code/exercism/go/$(ls -t $HOME/code/exercism/go/ | head -1)'
alias gtb='go test -bench=. -benchmem -cpuprofile cprofile.out -memprofile mprofile.out'
alias cprof='go tool pprof -http=":9001" cprofile.out'
alias mprof='go tool pprof -http=":9001" mprofile.out'
alias gt='richgo test ./...'

alias ez='n ~/.dotfiles/roles/zsh/files/zsh/.zshrc;source $ZDOTDIR/.zshrc'
alias .d='cd ~/.dotfiles'
alias ma='make'
alias mt='make test'
alias tgo='testomatic --config ~/.testomatic.yml'

export ANSIBLE_NOCOWS=1

# completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
 # Force prefix matching, avoid partial globbing on path
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' cache-path $ZDOTDIR/cache

# ignore case
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# menu if nb items > 2
# zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
 # list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# source ~/.config/zsh/aws_zsh_completer.sh

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

alias m='~/.tmux/mux.sh'
alias mux='tmuxinator'
alias tmux='tmux -2'

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
alias tt='todotxt-machine'
alias tnn='n ~/Dropbox/todo/work/todo.txt'
alias tn='n ~/Dropbox/todo/todo.txt'
# alias nn='n +RecentNotes'
# alias ni='cd ~/Dropbox/1vimwiki && n +VimwikiIndex +ZettelOpen'
# alias nn='cd ~/Dropbox/1vimwiki && n +VimwikiIndex'
alias cm='cd ~/Dropbox/1vimwiki/notes/meetings/ && n +CreateMeetingNote'
alias no='cd ~/Dropbox/1vimwiki/notes/ && n $(date "+%Y-%m-%d").md'
alias nw='cd ~/Dropbox/1vimwiki/ && n'
# alias t='~/tools/todo.txt_cli-2.9/todo.sh -d ~/Dropbox/todo/work/todo.cfg'
alias t='todo.sh -f -n'
alias tl='t list'
alias tlp='t lsp'
alias tb='t birdseye'
alias te='ts; t edit'
alias ta='t add'
alias tp='t pri'
# alias ta='t autopri'
alias tap='ts; echo "autoprio 0 days = A\n";t autopri 0 A; echo "autoprio 1 days = B\n"; t autopri 1 B; echo "autoprio 7 days = C\n"; t autopri 7 C;ts'
alias ts='t commit'
alias td='ts; t del'
alias tf='t do'
alias tm='t mit'
alias tmd='t mit today'
alias tgl='cd ~/Dropbox/todo/work/ && glog'
# https://github.com/samuelsnyder/outline-todo.txt
alias to='t outline'
alias tol='t outline ls'
alias toa='t outline addto' # PROJECT "TEXT"
alias toe='ts; t outline edit' # PROJECT
alias toi='ts; t outline import; tap' # sync from outlines
# Create an outline file corresponding to PROJECT, and move task at line #ITEM in todo.txt to the outline.
alias toc='t outline mkol' # PROJECT [#ITEM]
alias tom='ts; t outline mv' # #ITEM PROJECT

# alias nn='n +VimwikiIndex +ZettelOpen'
# TODO
# alias nn='n +VimwikiIndex +ZettelNew'

# function zd() {
#     file="/tmp/base_$(date '+%H%M%S').json"
#   echo $1 | sed -r 's/\\\\r\\\\n//g' | base64 -d | zlib -d > $file;n $file
#   echo "n $file"
# }

# latest payload
# function payload() {
#     nvim $(find /tmp/payload* -printf '%p\n' | sort -r | head -1)
# }

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
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

zle -N edit-command-line
# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"


# [ -f ~/.~/.powerlevel10k/powerlevel10k.zsh-theme ] && source ~/.powerlevel10k/powerlevel10k.zsh-theme

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/tools/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/tools/google-cloud-sdk/completion.zsh.inc'; fi


if test -f "$TERM_BRIGHT"; then
    export BAT_THEME="gruvbox-light"
else
    export BAT_THEME="gruvbox"
fi

export PATH="$HOME/.rbenv/versions/2.7.1/bin:$PATH"

# fnm
# export PATH=$HOME/.fnm:$PATH
# eval "`fnm env`"

# if [ -e /home/jan/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jan/.nix-profile/etc/profile.d/nix.sh; fi
#
### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"

zinit ice lucid nocd depth=1; zinit light romkatv/powerlevel10k

# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
#
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl

zinit ice wait lucid
zinit light "dominik-schwabe/zsh-fnm"
zinit ice wait'1' lucid
zinit light "MichaelAquilina/zsh-autoswitch-virtualenv"
zinit ice wait'1' lucid
zinit snippet OMZP::rbenv
zinit ice wait'1' as"completion" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit ice wait'1' as"completion" lucid
zinit snippet https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/terraform/_terraform

# zsh-fzy
zinit ice wait'2' lucid
zinit light aperezdc/zsh-fzy

# git fuzzy TODO
# zinit ice wait'!0' lucid as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
# zinit light bigH/git-fuzzy
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

### End of Zinit's installer chunk

# start second tracing block
# unsetopt XTRACE
# exec 2>&3 3>&-
# end tracing

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# zprof
