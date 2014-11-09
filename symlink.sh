#!/usr/bin/zsh

DOTDIR="$HOME/.dotfiles"

#fetch all submodules
cd $DOTDIR && git submodule init && git submodule update && git pull --recurse-submodules

echo 'linking i3 config'
ln -fs $DOTDIR/.i3/config $HOME/.i3/config

echo 'linking gtk files'
ln -fs $DOTDIR/.gtkrc-2.0 $HOME/.gtkrc-2.0
ln -fs $DOTDIR/settings.ini $HOME/.config/gtk-3.0/settings.ini

echo 'linking Xdefaults'
ln -fs $DOTDIR/.Xdefaults $HOME/.Xdefaults

echo 'linking ack config'
ln -fs $DOTDIR/.ackrc $HOME/.ackrc

echo 'linking vim files'
ln -fs $DOTDIR/php-vim-setup/.vim $HOME/
ln -fs $DOTDIR/php-vim-setup/.vimrc $HOME/.vimrc
ln -fs $DOTDIR/php-vim-setup/.gvimrc $HOME/.gvimrc
echo 'installing vundle plugins'
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginClean +qall
vim +PluginInstall +qall

echo 'setup prezto zsh'
setopt EXTENDED_GLOB
for rcfile in $DOTDIR/prezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "$HOME/.${rcfile:t}"
done
