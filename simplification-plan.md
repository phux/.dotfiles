# Migration Plan: Ansible to Shell Scripts (Ubuntu LTS)

## Overview
This document outlines the detailed plan to migrate the dotfiles provisioning system from Ansible to a modular, idempotent shell script architecture utilizing GNU Stow. The goal is a simplified, faster, and more maintainable setup tailored specifically for modern Ubuntu LTS environments, without the overhead of Ansible or Vagrant.

## Phase 1: GNU Stow Reorganization
The current Ansible `roles/*/files/` and `roles/*/templates/` structure will be extracted and reorganized into a GNU Stow compatible directory.

* **Action:** Create `.dotfiles/stow/` directory.
* **Mapping Strategy:**
  * Each top-level directory in `stow/` represents a "package" (e.g., `zsh`, `git`, `neovim`, `i3`).
  * The internal structure of each package perfectly mirrors the target home directory structure.
  * *Example:* `roles/zsh/files/zshrc` moves to `stow/zsh/.config/zsh/.zshrc`.
  * *Example:* `roles/git/files/gitconfig` moves to `stow/git/.gitconfig`.
* **Benefit:** Allows a single command (`stow -t ~ -d ./stow */`) to perfectly symlink all configurations, making them easily trackable and revertible.

## Phase 2: Core Library Development (`lib/helpers.sh`)
To maintain Ansible's idempotency (safe to run multiple times), a robust bash library will be created.

* **Functions to Implement:**
  * `print_info()`, `print_success()`, `print_error()`, `print_warning()`: Consistent, colored terminal output.
  * `pkg_installed(pkg_name)`: Verifies if a package exists via `dpkg -l` or `command -v`.
  * `install_packages(pkg_list)`: Filters the list against installed packages and runs `sudo apt-get install -y` only for missing ones.
  * `add_ppa(ppa_name)`: Checks `/etc/apt/sources.list.d/` before adding a new repository to prevent duplicates.
  * `get_latest_github_release(repo)`: Uses `curl` and `jq` (or `awk`) to dynamically query the GitHub API for the latest release tag (crucial for tools like ActivityWatch).
  * `clone_or_update_repo(url, dest)`: Idempotently clones a git repository or pulls the latest changes if it already exists.

## Phase 3: Modular Script Development (`scripts/`)
The Ansible YAML tasks will be translated into sequentially numbered, logical shell scripts.

### `scripts/00-core.sh` (Foundation)
* Request sudo privileges upfront.
* Run `sudo apt update` and `sudo apt upgrade -y`.
* Install critical base dependencies: `stow`, `curl`, `wget`, `git`, `build-essential`, `software-properties-common`, `jq`, `unzip`.

### `scripts/01-stow.sh` (Dotfiles Linking)
* Ensure target directories (e.g., `~/.config`, `~/.local/bin`) exist to prevent Stow from symlinking entire parent directories.
* Execute `stow -t ~ -d ./stow */` to link all configurations.

### `scripts/02-shell.sh` (Terminal Experience)
* Install shells and multiplexers: `zsh`, `tmux`.
* Install modern CLI utilities: `bat` (handling the `batcat` alias on Ubuntu), `fzf`, `ripgrep`, `fd-find`, `eza` (if replacing ls).
* Change the default login shell to `zsh` safely using `chsh`, only if it isn't already the default.

### `scripts/03-dev-tools.sh` (Development Environments)
* Install language ecosystems: `golang-go`, `php-cli`, `ruby`, `nodejs`, `npm`.
* Install and configure version managers: clone/update `pyenv` and `tfenv` to `~/.pyenv` and `~/.tfenv`.
* Install Docker using the official Docker apt repository for modern Ubuntu LTS, ensuring the user is added to the `docker` group.

### `scripts/04-desktop.sh` (UI & Applications)
* Install desktop environments and tools: `i3`, `rofi`, `keepassxc`, `feh`, `chromium-browser`, `autorandr`.
* **ActivityWatch:** Dynamically fetch the latest release zip from GitHub, extract it (target: `~/.local/opt/activitywatch`), and configure a `.desktop` entry for easy launching.
* Install necessary fonts (e.g., Nerd Fonts) to `~/.local/share/fonts` and run `fc-cache`.

## Phase 4: Main Entrypoint & Cleanup
* **`install.sh`**: Create the master executable script at the repository root. It will source `lib/helpers.sh` and execute all scripts in `scripts/` sequentially.
* **`Makefile`**: Update the existing `Makefile` commands. `make provision` or `make install` will execute `./install.sh`.
* **Cleanup Strategy:** Safely remove all Ansible and Vagrant artifacts to finalize the migration:
  * `rm -rf roles/`
  * `rm -rf group_vars/`
  * `rm hosts playbook.yml Vagrantfile`
