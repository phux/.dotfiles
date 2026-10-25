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
    git-delta
    tmuxinator
)

# Install standard packages
install_packages "${SHELL_PACKAGES[@]}"

# Handle bat -> batcat and fd -> fdfind aliases for Ubuntu
if command_exists batcat; then
    symlink_bin batcat bat
fi

if command_exists fdfind; then
    symlink_bin fdfind fd
fi

# Newer fzf and fd than Ubuntu ships: fzf-lua needs a recent fzf, and fd 10 lists files faster.
# Pinned and sha256-verified. The apt packages above stay: fzf's shell integration files come from
# the apt package, and the apt binaries are the fallback if a download fails.
# fd is the -gnu build on purpose: the static -musl build lists files ~8x slower (musl allocator).
# To bump a version, take the new hash from the release page (fzf: *_checksums.txt, fd: asset digest).
FZF_VERSION="0.74.5"
FZF_SHA256="d47d7f882972c7d674dbbba998ffa4116e68379616ffac7695d0671e9a722c5f"
FD_VERSION="10.5.0"
FD_SHA256="a1259cd129636efbc3fef123525c1b49e88fe5088c012630983c310e52fdfa95"

install_release_binary fzf "$FZF_VERSION" \
    "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" "$FZF_SHA256"
install_release_binary fd "$FD_VERSION" \
    "https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" "$FD_SHA256"

# gitleaks scans staged changes in .githooks/pre-commit. The apt version (8.16) has no `git` command, so there is no apt fallback.
# Hash: gitleaks_*_checksums.txt on the release page.
GITLEAKS_VERSION="8.30.1"
GITLEAKS_SHA256="551f6fc83ea457d62a0d98237cbad105af8d557003051f41f3e7ca7b3f2470eb"
install_release_binary gitleaks "$GITLEAKS_VERSION" \
    "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz" "$GITLEAKS_SHA256"

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
