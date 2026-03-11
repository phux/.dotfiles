#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 00: Core utilities"

# Request Sudo privileges upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

print_info "Updating apt packages"
sudo apt update -y && sudo apt upgrade -y

CORE_PACKAGES=(
    stow
    curl
    wget
    git
    build-essential
    software-properties-common
    jq
    unzip
    ca-certificates
    gnupg
    lsb-release
)

install_packages "${CORE_PACKAGES[@]}"
print_success "Phase 00: Core completed"
