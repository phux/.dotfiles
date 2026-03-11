#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 02: Terminal Experience (Zsh, Tmux, CLI tools)"

# Modern Ubuntu packages for terminal
SHELL_PACKAGES=(
    zsh
    tmux
    ripgrep
    fd-find
    fzf
    bat
    eza
    xclip
)

# Install standard packages
sudo apt update
install_packages "${SHELL_PACKAGES[@]}"

# Handle bat -> batcat and fd -> fdfind aliases for Ubuntu
if command_exists batcat; then
    symlink_bin batcat bat
fi

if command_exists fdfind; then
    symlink_bin fdfind fd
fi

# Change default shell to zsh safely
if [ "$SHELL" != "$(command -v zsh)" ]; then
    print_info "Changing default login shell to Zsh..."
    chsh -s "$(command -v zsh)"
    print_success "Shell changed. You will need to log out and log back in for this to fully take effect."
else
    print_info "Zsh is already the default shell."
fi

# Clone TPM for tmux
TPM_DIR="$HOME/.tmux/plugins/tpm"
clone_or_update_repo "https://github.com/tmux-plugins/tpm" "$TPM_DIR"

# Install Sheldon plugin manager
if ! command_exists sheldon; then
    print_info "Installing Sheldon for zsh plugin management..."
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to "$HOME/.local/bin"
fi

print_success "Phase 02: Terminal Experience completed"
