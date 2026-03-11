#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 03: Development Environments (Go, Node, PHP, Python, Terraform)"

# Setup Go, PHP, Ruby from standard repos (we'll rely on version managers for Node, Python, TF)
DEV_PACKAGES=(
    golang-go
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

# Setup Docker
if ! command -v docker &> /dev/null; then
    print_info "Installing Docker Engine"
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
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
if ! command -v fnm &> /dev/null; then
    print_info "Installing FNM (Node Version Manager)"
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
fi

print_success "Phase 03: Development Environments completed"
