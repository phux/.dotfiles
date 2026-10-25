#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 00: Core utilities"

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
