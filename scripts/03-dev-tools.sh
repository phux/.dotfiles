#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 03: Development Environments (Go, Node, PHP, Python, Terraform)"

# Setup Go, PHP, Ruby from standard repos (we'll rely on version managers for Node, Python, TF, Go)
DEV_PACKAGES=(
  php-cli
  php-xml
  php-mbstring
  php-curl
  ruby-full
  pandoc
  shfmt
  texlive-xetex
  texlive-latex-recommended
  texlive-latex-extra
  texlive-fonts-extra
  librsvg2-bin
)

install_packages "${DEV_PACKAGES[@]}"

# Setup GVM (Go Version Manager)
if [ ! -d "$HOME/.gvm" ]; then
  print_info "Installing GVM"
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
else
  print_info "GVM is already installed."
fi

# Make GVM available in this session
source "$HOME/.gvm/scripts/gvm" 2>/dev/null

if command -v gvm &>/dev/null; then
  # Install go1.4 for bootstrapping if needed or use binary
  if ! gvm list | grep -q "go1.26.1"; then
    print_info "Installing Go 1.26.1 via GVM"
    gvm install go1.26.1 -B || print_error "Failed to install Go 1.26.1"
    gvm use go1.26.1 --default
  else
    print_info "Go 1.26.1 is already installed."
    gvm use go1.26.1 --default
  fi
fi
# Setup Docker
if ! command -v docker &>/dev/null; then
  print_info "Installing Docker Engine"
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo usermod -aG docker "$USER"
  print_success "Docker installed. Added $USER to docker group."
else
  print_info "Docker is already installed."
fi

# Ensure user is in video group for camera access
sudo usermod -aG video "$USER"

# Setup uv (manages Python versions and per-project .venv)
if ! command -v uv &>/dev/null && [ ! -f "$HOME/.cargo/bin/uv" ] && [ ! -f "$HOME/.local/bin/uv" ]; then
  print_info "Installing uv"
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  print_info "uv is already installed."
fi

# Setup Tfenv
clone_or_update_repo "https://github.com/tfutils/tfenv.git" "$HOME/.tfenv" 1
symlink_bin "$HOME/.tfenv/bin/tfenv" tfenv
symlink_bin "$HOME/.tfenv/bin/terraform" terraform
# Setup FNM (Fast Node Manager)
if ! command -v fnm &>/dev/null; then
  print_info "Installing FNM (Node Version Manager)"
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
fi

# Ensure fnm and node are available in the current session
export PATH="$HOME/.local/bin:$HOME/.local/share/fnm:$PATH"
if command -v fnm &>/dev/null; then
  eval "$(fnm env)"
  if ! fnm current &>/dev/null; then
    print_info "Installing default Node.js version via fnm"
    fnm install 24
    fnm default 24
    fnm use 24
  fi
fi

# Setup global npm packages
if command_exists npm; then
  print_info "Installing global npm packages"
  NPM_GLOBALS=(
    neovim
    markdownlint-cli2
    eslint
    typescript
    eslint_d
    prettier
    @fsouza/prettierd
    markmap-cli
    @anthropic-ai/claude-code
    @google/gemini-cli
    @opencode/cli
    mermaid-filter
  )
  # npm no longer runs install scripts unless allowed. These three download or link a binary the tool needs.
  NPM_ALLOW_SCRIPTS=@anthropic-ai/claude-code,@opencode/cli,puppeteer
  npm install -g --allow-scripts="$NPM_ALLOW_SCRIPTS" "${NPM_GLOBALS[@]}"
else
  print_warning "npm is not available yet in this session. Skipping npm global packages."
fi

# Setup Python formatters and linters used by neovim (conform, nvim-lint)
if command_exists uv; then
  print_info "Installing uv tools"
  for tool in ruff sqruff proselint ansible-lint; do
    uv tool install "$tool"
  done
else
  print_warning "uv is not available. Skipping uv tools."
fi

# Setup Composer
if ! command -v composer &>/dev/null; then
  print_info "Installing Composer"
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  print_success "Composer installed."
else
  print_info "Composer is already installed."
fi

# Install the global composer packages from stow/php/.config/composer/composer.json (php-cs-fixer and phpstan are used
# by neovim). Link them into ~/.local/bin, because the shell PATH has no composer bin dir.
if command_exists composer; then
  print_info "Installing composer tools"
  composer global update
  COMPOSER_BIN="$(composer global config bin-dir --absolute 2>/dev/null)"
  symlink_bin "$COMPOSER_BIN/php-cs-fixer" php-cs-fixer
  symlink_bin "$COMPOSER_BIN/phpstan" phpstan
fi

# Setup gcloud CLI
if ! command -v gcloud &>/dev/null; then
  print_info "Installing gcloud CLI"
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/cloud.google.gpg
  echo "deb [signed-by=/etc/apt/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list >/dev/null
  sudo apt-get update && sudo apt-get install -y google-cloud-cli
  print_success "gcloud CLI installed."
else
  print_info "gcloud CLI is already installed."
fi

# Setup Neovim
if ! command -v nvim &>/dev/null; then
  print_info "Installing Neovim from source"

  # Install build dependencies
  install_packages ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl luajit

  # Clone and build
  ensure_dir "$HOME/tools"
  clone_or_update_repo "https://github.com/neovim/neovim.git" "$HOME/tools/neovim"

  (cd "$HOME/tools/neovim" && make CMAKE_BUILD_TYPE=Release && sudo make install) || print_error "Failed to build Neovim"
  print_success "Neovim installed."
else
  print_info "Neovim is already installed."
fi

print_success "Phase 03: Development Environments completed"
