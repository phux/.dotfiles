#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 05: Fonts"

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/FiraCode-Regular.ttf" ]; then
    print_info "Installing FiraCode Nerd Font..."
    wget -qO /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
    unzip -q /tmp/FiraCode.zip -d "$FONT_DIR"
    rm /tmp/FiraCode.zip
    fc-cache -fv
    print_success "Fonts installed."
else
    print_info "FiraCode Nerd Font already installed."
fi

print_success "Phase 05: Fonts completed"
