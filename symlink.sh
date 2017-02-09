#!/usr/bin/zsh

DOTDIR="$HOME/.dotfiles"

echo 'linking i3 config'
mkdir -p $HOME/.i3
cd $HOME/.i3/
ln -fs $DOTDIR/* .

echo 'linking .Xresources'
ln -fs $DOTDIR/.Xresources $HOME/.Xresources

echo 'installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -fs $DOTDIR/.zshrc $HOME/.zshrc

echo 'linking nvim init.vim'
mkdir -p $HOME/.config/nvim
ln -fs $DOTDIR/init.vim $HOME/.config/nvim/
