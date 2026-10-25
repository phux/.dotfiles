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
    dpkg-query -W -f='${Status}' "$1" 2> /dev/null | grep -q "install ok installed"
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

command_exists() {
    command -v "$1" &> /dev/null
}

ensure_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        print_info "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

symlink_bin() {
    local target_cmd="$1"
    local link_name="$2"
    local bin_dir="$HOME/.local/bin"
    ensure_dir "$bin_dir"
    
    local target_path
    if [[ "$target_cmd" == /* ]]; then
        target_path="$target_cmd"
    else
        target_path=$(command -v "$target_cmd")
    fi

    if [ -n "$target_path" ] && [ ! -L "$bin_dir/$link_name" ]; then
        print_info "Symlinking $target_cmd to $bin_dir/$link_name"
        ln -sf "$target_path" "$bin_dir/$link_name"
    elif [ -z "$target_path" ]; then
        print_warning "Target command '$target_cmd' not found for symlinking."
    fi
}

# Install a pinned release binary from a .tar.gz: download, verify the sha256, install it to
# ~/.local/opt/NAME-VERSION/NAME and link ~/.local/bin/NAME to it. Usage: NAME VERSION URL SHA256
# x86_64 only (the hashes belong to these builds). On any failure nothing is changed, so the apt version stays.
# The link is a symlink on purpose: symlink_bin leaves existing symlinks alone, so a later run of
# 02-shell.sh cannot swap it back for the apt binary.
install_release_binary() {
    local name="$1" version="$2" url="$3" sha256="$4"
    local opt_dir="$HOME/.local/opt/$name-$version"
    local link="$HOME/.local/bin/$name"

    if [ -x "$opt_dir/$name" ] && [ "$(readlink "$link")" = "../opt/$name-$version/$name" ]; then
        print_info "$name $version is already installed."
        return 0
    fi
    if [ "$(uname -m)" != "x86_64" ]; then
        print_warning "No pinned $name release for $(uname -m). Keeping the apt version."
        return 0
    fi

    local tmp
    tmp=$(mktemp -d) || return 1
    print_info "Installing $name $version"
    if ! curl --proto '=https' -fLsS -o "$tmp/archive.tar.gz" "$url"; then
        print_warning "Download of $name $version failed. Keeping the apt version."
        rm -rf -- "$tmp"
        return 1
    fi
    if ! echo "$sha256  $tmp/archive.tar.gz" | sha256sum --check --status; then
        print_error "sha256 mismatch for $name $version. Not installing it."
        rm -rf -- "$tmp"
        return 1
    fi

    tar -xzf "$tmp/archive.tar.gz" -C "$tmp"
    local bin
    bin=$(find "$tmp" -type f -name "$name" | head -1)
    if [ -z "$bin" ]; then
        print_error "No '$name' binary in the $name $version archive."
        rm -rf -- "$tmp"
        return 1
    fi

    ensure_dir "$HOME/.local/bin"
    install -D -m 0755 "$bin" "$opt_dir/$name"
    ln -sfn "../opt/$name-$version/$name" "$link"
    rm -rf -- "$tmp"
    print_success "Installed $name $version to $opt_dir"
}

clone_or_update_repo() {
    local url="$1"
    local dest="$2"
    local depth="${3:-}"
    
    local depth_flag=""
    if [ -n "$depth" ]; then
        depth_flag="--depth $depth"
    fi

    if [ ! -d "$dest" ]; then
        print_info "Cloning $url to $dest"
        git clone $depth_flag "$url" "$dest" || print_error "Failed to clone $url"
    else
        print_info "Updating $dest"
        (cd "$dest" && git pull --quiet) || print_warning "Failed to update $dest"
    fi
}
