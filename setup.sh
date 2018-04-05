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

  echo 'running golang tooling setup'
  sh "$DIR/go-tooling.sh"

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
  nvim +GoUpdateBinaries +GoDoctorInstall +qall /tmp/needed_file.go # opening file to load vim-go

  gometalinter --install



  echo 'linking tmux conf'
  ln -fs "$DIR/.tmux.conf" $HOME/

  echo 'setting up git'
  ln -fs "$DIR/git_ignore" "$HOME/.git_ignore"
  git config --global init.templatedir "$DIR/.git_templates"

  echo 'running php tooling setup'
  sh "$DIR/php-tooling.sh"
  ln -fs "$DIR/.easy-coding-standard5.yml" $HOME/
  ln -fs "$DIR/.easy-coding-standard7.yml" $HOME/

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
    eval "$(rbenv init -)"
    mkdir -p "$(rbenv root)"/plugins
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    rbenv install 2.5.1 #todo: figure out how to get latest version
    rbenv global 2.5.1
  fi

  echo 'Installing vim deps'
  if ! type "livedown" > /dev/null; then
    npm install -g livedown
  fi

  echo 'Installing linters'

  if ! type "pyflakes" > /dev/null; then
    pip install --upgrade pyflakes
  fi
  if ! type "flake8" > /dev/null; then
    pip install --upgrade flake8
  fi
  if ! type "proselint" > /dev/null; then
    pip install --upgrade proselint
  fi
  if ! type "yamllint" > /dev/null; then
    pip install yamllint
  fi

  if ! type "write-good" > /dev/null; then
    npm install -g write-good
  fi
  if ! type "markdownlint" > /dev/null; then
    npm install -g markdownlint-cli
  fi

  if ! type "jsonlint" > /dev/null; then
    npm install jsonlint -g
  fi
  if ! type "stylelint" > /dev/null; then
    npm install -g stylelint
  fi

  if ! type "mdl" > /dev/null; then
    gem install mdl
  fi
  if ! type "scss-lint" > /dev/null; then
    gem install scss_lint
  fi
  if ! type "sqlint" > /dev/null; then
    gem install sqlint
  fi

  if ! type "shellcheck" > /dev/null; then
    sudo apt-get install shellcheck
  fi

}

vared -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -c tmp;
echo "";
if [[ $tmp =~ ^[Yy]$ ]]; then
  installIt;
fi;
