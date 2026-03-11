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
    arandr
    python3-gpg
)

install_packages "${DESKTOP_PACKAGES[@]}"

# Setup Dropbox
if ! command -v dropbox &> /dev/null; then
    print_info "Installing Dropbox"
    # libpango1.0-0 was renamed to libpango-1.0-0 in newer Ubuntu; install it first
    # then force-install the deb to bypass the stale dependency name
    sudo apt-get install -y libpango-1.0-0
    curl -L "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb" -o /tmp/dropbox.deb
    sudo dpkg -i --force-depends /tmp/dropbox.deb
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


# Setup Slack
if ! command -v slack &> /dev/null; then
    print_info "Installing Slack"
    if command -v snap &> /dev/null; then
        sudo snap install slack --classic
        print_success "Slack installed via snap."
    else
        print_warning "Snap is not installed. Skipping Slack installation."
        print_info "You can install Slack manually from https://slack.com/downloads/linux"
    fi
else
    print_info "Slack is already installed."
fi

print_success "Phase 04: Desktop Applications completed"
