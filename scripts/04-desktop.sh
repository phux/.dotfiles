#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 04: Desktop & Applications (i3, rofi, autorandr)"

DESKTOP_PACKAGES=(
    i3
    i3lock
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
    arandr
    python3-gpg
    libxcb-screensaver0-dev
    libxcb-xkb-dev
    libxcb-dpms0-dev
    libx11-xcb-dev
    libxcb-render0-dev
    libxcb-shape0-dev
    libxcb-xfixes0-dev
    libpulse-dev
    pulseaudio-utils
    pavucontrol
    v4l-utils
    v4l2loopback-dkms
    v4l2-relayd
    libcamhal-ipu7x
    gstreamer1.0-icamera
    xdg-desktop-portal
    xdg-desktop-portal-gtk
)

install_packages "${DESKTOP_PACKAGES[@]}"

# Setup xidlehook
if ! command_exists xidlehook; then
    print_info "Installing xidlehook via cargo"
    cargo install xidlehook --locked
    print_success "xidlehook installed"
else
    print_info "xidlehook already installed."
fi

# Setup Dropbox
if ! command_exists dropbox; then
    print_info "Installing Dropbox"
    curl -L "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2024.04.17_amd64.deb" -o /tmp/dropbox.deb
    sudo apt-get install -y /tmp/dropbox.deb
    rm -f /tmp/dropbox.deb
    print_success "Dropbox installed"
else
    print_info "Dropbox already installed. Skipping."
fi

# Setup ActivityWatch
AW_DIR="$HOME/.local/opt/activitywatch"
if [ ! -d "$AW_DIR" ]; then
    print_info "Installing ActivityWatch (latest release from GitHub)"
    
    LATEST_VERSION=$(get_latest_github_release "ActivityWatch/activitywatch")
    DOWNLOAD_URL="https://github.com/ActivityWatch/activitywatch/releases/download/${LATEST_VERSION}/activitywatch-${LATEST_VERSION}-linux-x86_64.zip"
    
    ensure_dir "$AW_DIR"
    curl -L "$DOWNLOAD_URL" -o /tmp/activitywatch.zip
    unzip -q /tmp/activitywatch.zip -d "$AW_DIR"
    mv "$AW_DIR"/activitywatch*/* "$AW_DIR"/
    rm -rf "$AW_DIR"/activitywatch-*/ /tmp/activitywatch.zip
    
    # Create desktop entry for application menu integration
    ensure_dir "$HOME/.local/share/applications"
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


# Setup Slack
if ! command_exists slack; then
    print_info "Installing Slack"
    if command_exists snap; then
        sudo snap install slack --classic
        print_success "Slack installed via snap."
    else
        print_warning "Snap is not installed. Skipping Slack installation."
        print_info "You can install Slack manually from https://slack.com/downloads/linux"
    fi
else
    print_info "Slack is already installed."
fi

# Setup Obsidian
if ! command_exists obsidian; then
    print_info "Installing Obsidian"
    if command_exists snap; then
        sudo snap install obsidian --classic
        print_success "Obsidian installed via snap."
    else
        print_warning "Snap is not installed. Skipping Obsidian installation."
        print_info "You can install Obsidian manually from https://obsidian.md/download"
    fi
else
    print_info "Obsidian is already installed."
fi



# Setup Camera Permissions for Snaps
if command_exists snap; then
    print_info "Connecting Snap camera interfaces..."
    sudo snap connect chromium:camera || true
    sudo snap connect slack:camera || true
fi
print_success "Phase 04: Desktop Applications completed"
