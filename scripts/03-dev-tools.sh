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
	libssl-dev
	zlib1g-dev
	libbz2-dev
	libreadline-dev
	libsqlite3-dev
	llvm
	libncursesw5-dev
	xz-utils
	tk-dev
	libxml2-dev
	libxmlsec1-dev
	libffi-dev
	liblzma-dev
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

if command -v gvm &> /dev/null; then
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

# Setup Pyenv
if [ ! -d "$HOME/.pyenv" ]; then
	print_info "Installing Pyenv"
	curl https://pyenv.run | bash
else
	print_info "Updating Pyenv"
	(cd "$HOME/.pyenv" && git pull)
fi

# Setup uv
if ! command -v uv &>/dev/null && [ ! -f "$HOME/.cargo/bin/uv" ] && [ ! -f "$HOME/.local/bin/uv" ]; then
	print_info "Installing uv"
	curl -LsSf https://astral.sh/uv/install.sh | sh
else
	print_info "uv is already installed."
fi

# Setup Tfenv
if [ ! -d "$HOME/.tfenv" ]; then
	print_info "Installing Tfenv"
	git clone --depth=1 https://github.com/tfutils/tfenv.git "$HOME/.tfenv"
	ln -sf "$HOME/.tfenv/bin/tfenv" "$HOME/.local/bin/tfenv"
	ln -sf "$HOME/.tfenv/bin/terraform" "$HOME/.local/bin/terraform"
else
	print_info "Updating Tfenv"
	(cd "$HOME/.tfenv" && git pull)
fi
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
		fnm install 20
		fnm default 20
		fnm use 20
	fi
fi

# Setup global npm packages
if command -v npm &>/dev/null; then
	print_info "Installing global npm packages (yarn, neovim, linters, etc.)"
	npm install -g yarn neovim instant-markdown-d live-server jsonlint fixjson markdownlint-cli serverless stylelint write-good remark-lint remark-preset-lint-recommended tern eslint tern-lint typescript eslint-config-standard eslint-plugin-node eslint-plugin-promise eslint-plugin-standard htmllint textlint textlint-rule-write-good eslint_d csslint prettier @fsouza/prettierd lua-fmt @ocular-d/vale-bin markmap-cli
else
	print_warning "npm is not available yet in this session. Skipping npm global packages."
fi

# Setup Composer
if ! command -v composer &>/dev/null; then
	print_info "Installing Composer"
	curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
	print_success "Composer installed."
else
	print_info "Composer is already installed."
fi

# Setup AI Tools

# Setup Neovim
if ! command -v nvim &>/dev/null; then
	print_info "Installing Neovim from source"

	# Install build dependencies
	install_packages ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl luajit

	# Clone and build
	mkdir -p "$HOME/tools"
	if [ ! -d "$HOME/tools/neovim" ]; then
		git clone https://github.com/neovim/neovim.git "$HOME/tools/neovim"
	else
		(cd "$HOME/tools/neovim" && git pull)
	fi

	(cd "$HOME/tools/neovim" && make CMAKE_BUILD_TYPE=Release && sudo make install)
	print_success "Neovim installed."
else
	print_info "Neovim is already installed."
fi

print_info "Installing AI CLI tools (Claude, Gemini, Opencode)"

# Install Claude (via npm if fnm/node is available)
if command -v npm &>/dev/null; then
	print_info "Installing @anthropic-ai/claude-code globally via npm"
	npm install -g @anthropic-ai/claude-code

	print_info "Installing @google/gemini-cli globally via npm"
	npm install -g @google/gemini-cli

	print_info "Installing opencode-ai globally via npm"
	npm install -g opencode-ai
else
	print_info "npm is not available yet in this session. Skipping npm-based AI tools."
	print_info "You may need to run 'fnm install 20 && fnm use 20' and then run this script again."
fi

print_success "Phase 03: Development Environments completed"
