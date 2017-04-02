#!/usr/bin/zsh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo 'linking i3 config'
mkdir -p $HOME/.i3
ln -fs $DIR/i3/* $HOME/.i3/

echo 'linking .Xresources'
ln -fs "$DIR/.Xresources" $HOME/

echo 'setting up zsh'
ln -fs "$DIR/.zshrc" $HOME/
if [ ! -f "$HOME/antigen.zsh" ]; then
    echo 'installing antigen for zsh'
    curl -L git.io/antigen > "$HOME/antigen.zsh"
fi

echo 'linking init.vim'
mkdir -p $HOME/.config/nvim
ln -fs "$DIR/init.vim" $HOME/.config/nvim/

echo 'linking public project config'
ln -fs "$DIR/.projects.public.vim" $HOME/

echo 'linking tmux conf'
ln -fs "$DIR/.tmux.conf" $HOME/

echo 'setting up git hooks'
ln -fs "$DIR/.git_templates" $HOME/
git config --global init.templatedir '~/.git_templates'

echo 'running php tooling setup'
sh "$DIR/php-tooling.sh"
