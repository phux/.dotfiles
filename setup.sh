#!/usr/bin/env bash

function installIt() {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    echo 'linking i3 config'
    mkdir -p $HOME/.i3
    ln -fs $DIR/i3/* $HOME/.i3/

    echo 'linking .Xresources'
    ln -fs "$DIR/.Xresources" $HOME/

    echo 'setting up zsh'
    ln -fs "$DIR/.zshrc" $HOME/
    if [ ! -d "$HOME/.zplug" ]; then
        echo 'installing zplug for zsh'
        curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
    fi

    NVIM_DIR="$HOME/.config/nvim"
    echo 'linking init.vim'
    mkdir -p "$NVIM_DIR/ftplugin/"
    ln -fs "$DIR/init.vim" $NVIM_DIR
    ln -fs "$DIR/UltiSnips" $NVIM_DIR
    ln -fs "$DIR/ftplugin/*.vim" "$NVIM_DIR/ftplugin/"

    echo 'linking public project config'
    ln -fs "$DIR/.projects.public.vim" $NVIM_DIR

    echo 'linking tmux conf'
    ln -fs "$DIR/.tmux.conf" $HOME/

    echo 'setting up git hooks'
    ln -fs "$DIR/.git_templates" $HOME/
    git config --global init.templatedir '~/.git_templates'

    echo 'running php tooling setup'
    sh "$DIR/php-tooling.sh"

    if [ ! -f "$HOME/.local/share/fonts/Hack-Regular.ttf" ]; then
        echo 'installing fonts'
        # clone
        git clone https://github.com/powerline/fonts.git /tmp/fonts
        # install
        cd /tmp/fonts
        ./install.sh
        # clean-up a bit
        cd ..
        rm -rf fonts
    fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    installIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        installIt;
    fi;
fi;
unset installIt;
