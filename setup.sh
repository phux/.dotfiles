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
    echo 'installing antibody for zsh'
    curl -sL git.io/antibody | bash -s
    ln -fs "$DIR/.zsh_plugins.txt" $HOME/
    # compile initially
    antibody bundle < ~/.zsh_plugins.txt  > ~/.zsh_plugins.sh
    ln -fs "$DIR/gruvbox.sh" $HOME/.gruvbox.sh
    source ~/.zshrc

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

    echo 'setting up git'
    ln -fs "$DIR/git_ignore" "$HOME/.git_ignore"
    git config --global init.templatedir "$DIR/.git_templates"

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

    # mmh
    echo 'Installing Node'
    # curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
    nvm install node

    echo 'Installing pip'
    curl -o- https://bootstrap.pypa.io/get-pip.py | python

    echo 'Installing rbenv'
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    ~/.rbenv/bin/rbenv init

    echo 'Installing linters'
    sudo pip install --upgrade pyflakes
    sudo pip install --upgrade flake8
    sudo pip install --upgrade proselint

    npm install -g write-good
    gem install mdl
    npm install -g markdownlint-cli
    npm install jsonlint -g
    npm install -g stylelint
    gem install scss_lint
    sudo apt-get install shellcheck
    gem install sqlint
    sudo pip install yamllint
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
