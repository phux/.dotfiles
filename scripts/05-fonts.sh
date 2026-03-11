#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 05: Fonts"

FONT_DIR="$HOME/.local/share/fonts"
ensure_dir "$FONT_DIR"

if [ ! -f "$FONT_DIR/HackNerdFontMono-Regular.ttf" ]; then
    print_info "Installing Hack Nerd Font..."
    wget -qO /tmp/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
    unzip -q /tmp/Hack.zip -d "$FONT_DIR"
    rm /tmp/Hack.zip
    fc-cache -fv
    print_success "Fonts installed."
else
    print_info "Hack Nerd Font already installed."
fi

print_success "Phase 05: Fonts completed"
