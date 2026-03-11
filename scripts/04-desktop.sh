#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 04: Desktop & Applications (i3, rofi, autorandr)"

DESKTOP_PACKAGES=(
    i3
    rofi
    keepassxc
    feh
    autorandr
    chromium-browser
    thunar
    pcmanfm
    mousepad
    parcellite
    brightnessctl
    blueman
    graphviz
)

install_packages "${DESKTOP_PACKAGES[@]}"

# Setup ActivityWatch
AW_DIR="$HOME/.local/opt/activitywatch"
if [ ! -d "$AW_DIR" ]; then
    print_info "Installing ActivityWatch (latest release from GitHub)"
    
    LATEST_VERSION=$(get_latest_github_release "ActivityWatch/activitywatch")
    DOWNLOAD_URL="https://github.com/ActivityWatch/activitywatch/releases/download/${LATEST_VERSION}/activitywatch-${LATEST_VERSION}-linux-x86_64.zip"
    
    mkdir -p "$AW_DIR"
    curl -L "$DOWNLOAD_URL" -o /tmp/activitywatch.zip
    unzip -q /tmp/activitywatch.zip -d "$AW_DIR"
    mv "$AW_DIR"/activitywatch*/* "$AW_DIR"/
    rm -rf "$AW_DIR"/activitywatch-*/ /tmp/activitywatch.zip
    
    # Create desktop entry for application menu integration
    mkdir -p "$HOME/.local/share/applications"
    cat > "$HOME/.local/share/applications/activitywatch.desktop" << DESKTOP_EOF
[Desktop Entry]
Name=ActivityWatch
Exec=$AW_DIR/aw-qt
Icon=$AW_DIR/aw-qt.svg
Type=Application
Categories=Utility;
Terminal=false
DESKTOP_EOF
    print_success "ActivityWatch installed to $AW_DIR"
else
    print_info "ActivityWatch already exists at $AW_DIR. Skipping download."
fi

print_success "Phase 04: Desktop Applications completed"
