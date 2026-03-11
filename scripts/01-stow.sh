#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 01: Symlinking dotfiles using GNU Stow"

# Ensure common target directories exist
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/tools"

STOW_DIR="$(pwd)/stow"

if [ ! -d "$STOW_DIR" ]; then
    print_error "Stow directory $STOW_DIR does not exist!"
    exit 1
fi

cd "$STOW_DIR" || exit 1
stow -t "$HOME" -d "$STOW_DIR" */
print_success "Phase 01: Stow completed"
