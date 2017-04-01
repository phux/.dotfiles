#!/usr/bin/zsh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f "$HOME/antigen.zsh" ]; then
    echo 'installing antigen for zsh'
    curl -L git.io/antigen > "$HOME/antigen.zsh"
fi

echo 'linking i3 config'
mkdir -p $HOME/.i3
ln -fs "$DIR/i3/*" $HOME/.i3/

echo 'linking .Xresources'
ln -fs "$DIR/.Xresources" $HOME/.Xresources

echo 'installing oh-my-zsh'
ln -fs "$DIR/.zshrc" $HOME/.zshrc

echo 'linking init.vim'
mkdir -p $HOME/.config/nvim
ln -fs "$DIR/init.vim" $HOME/.config/nvim/

echo 'linking tmux conf'
ln -fs "$DIR/.tmux.conf" $HOME/.tmux.conf

echo 'running php tooling setup'
sh "$DIR/php-tooling.sh"
