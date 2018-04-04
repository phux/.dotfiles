#!/usr/bin/env zsh

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
    if ! type "antibody" > /dev/null; then
      curl -sL git.io/antibody | bash -s
    fi
    ln -fs "$DIR/.zsh_plugins.txt" $HOME/
    # compile initially
    antibody bundle < ~/.zsh_plugins.txt  > ~/.zsh_plugins.sh
    ln -fs "$DIR/gruvbox.sh" $HOME/.gruvbox.sh
    source ~/.zshrc

    NVIM_DIR="$HOME/.config/nvim"
    echo 'linking init.vim'
    ln -fs "$DIR/init.vim" $NVIM_DIR
    ln -fs "$DIR/UltiSnips" $NVIM_DIR
    mkdir -p "$NVIM_DIR/ftplugin/"
    ln -fs $DIR/ftplugin/*.vim "$NVIM_DIR/ftplugin/"

    echo 'linking public project config'
    ln -fs "$DIR/.projects.public.vim" $NVIM_DIR

    echo 'Loading nvim plugins'
    nvim +PlugInstall +qall

    echo 'linking tmux conf'
    ln -fs "$DIR/.tmux.conf" $HOME/

    echo 'setting up git'
    ln -fs "$DIR/git_ignore" "$HOME/.git_ignore"
    git config --global init.templatedir "$DIR/.git_templates"

    echo 'running php tooling setup'
    sh "$DIR/php-tooling.sh"

    echo 'running golang tooling setup'
    sh "$DIR/go-tooling.sh"

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

    # curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
    if ! type "node" > /dev/null; then
      # mmh
      echo 'Installing Node'
      nvm install node
    fi

    if ! type "pip" > /dev/null; then
      echo 'Installing pip'
      curl -o- https://bootstrap.pypa.io/get-pip.py | python
    fi

    if ! type "rbenv" > /dev/null; then
      echo 'Installing rbenv & ruby'
      git clone https://github.com/rbenv/rbenv.git ~/.rbenv
      cd ~/.rbenv && src/configure && make -C src
      ~/.rbenv/bin/rbenv init
      mkdir -p "$(rbenv root)"/plugins
      git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
      source ~/.zshrc
      rbenv install 2.5.1
    fi

    echo 'Installing linters'
    pip install --upgrade pyflakes
    pip install --upgrade flake8
    pip install --upgrade proselint
    pip install yamllint

    npm install -g write-good
    npm install -g markdownlint-cli
    npm install jsonlint -g
    npm install -g stylelint

    gem install mdl
    gem install scss_lint
    gem install sqlint

    sudo apt-get install shellcheck
}

vared -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -c tmp;
echo "";
if [[ $tmp =~ ^[Yy]$ ]]; then
    installIt;
fi;
