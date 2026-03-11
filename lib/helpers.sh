#!/usr/bin/env bash
# Core Idempotent Helpers for dotfiles installation

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }

pkg_installed() {
    dpkg -l "$1" &> /dev/null
}

install_packages() {
    local pkgs_to_install=()
    for pkg in "$@"; do
        if ! pkg_installed "$pkg"; then
            pkgs_to_install+=("$pkg")
        fi
    done

    if [ ${#pkgs_to_install[@]} -gt 0 ]; then
        print_info "Installing packages: ${pkgs_to_install[*]}"
        sudo apt-get install -y "${pkgs_to_install[@]}"
        print_success "Installed packages."
    else
        print_info "All packages already installed: $*"
    fi
}

add_ppa() {
    local ppa="$1"
    local ppa_file
    ppa_file=$(echo "$ppa" | sed 's/ppa://' | sed 's/\//-/g')
    if ! grep -rq "^deb .*$ppa" /etc/apt/ ; then
        print_info "Adding PPA: $ppa"
        sudo add-apt-repository -y "$ppa"
        sudo apt-get update
    else
        print_info "PPA $ppa already exists."
    fi
}

get_latest_github_release() {
    local repo="$1"
    curl -s "https://api.github.com/repos/$repo/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

clone_or_update_repo() {
    local url="$1"
    local dest="$2"
    if [ ! -d "$dest" ]; then
        print_info "Cloning $url to $dest"
        git clone "$url" "$dest"
    else
        print_info "Updating $dest"
        (cd "$dest" && git pull --quiet)
    fi
}
