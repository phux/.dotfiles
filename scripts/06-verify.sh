#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 06: Verification & Validation"

# 1. Check core binaries
BINS=(
    zsh
    tmux
    rg
    fd
    fzf
    bat
    eza
    nvim
    docker
    node
    npm
    go
    python3
    gcloud
)

MISSING_BINS=()
for bin in "${BINS[@]}"; do
    if ! command_exists "$bin"; then
        MISSING_BINS+=("$bin")
    fi
done

if [ ${#MISSING_BINS[@]} -gt 0 ]; then
    print_warning "Missing binaries in PATH: ${MISSING_BINS[*]}"
else
    print_success "All core binaries are installed and available."
fi

# 2. Check broken symlinks in home directory
print_info "Checking for broken stow symlinks..."
BROKEN_LINKS=$(find "$HOME" -maxdepth 2 -xtype l)
if [ -n "$BROKEN_LINKS" ]; then
    print_warning "Found broken symlinks:"
    echo "$BROKEN_LINKS" | while read -r link; do
        print_error "Broken link: $link -> $(readlink "$link")"
    done
else
    print_success "No broken stow symlinks found in ~ and ~/.config"
fi

# 3. Verify Docker permissions
if command_exists docker; then
    if groups | grep -q "docker"; then
        print_success "User is in the docker group."
    else
        print_warning "User is not in the docker group. You may need to log out and log back in."
    fi
fi

print_success "Phase 06: Verification completed."
