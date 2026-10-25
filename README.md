# ✨ My Awesome Dotfiles ✨

Welcome to my personal dotfiles repository! 🎉 This collection is designed to streamline and automate the setup of my development environment on Ubuntu LTS machines.

This repository uses **shell scripts + GNU Stow** for a faster, simpler, and more robust configuration experience. These dotfiles are the blueprint for a consistent, efficient, and delightful computing experience. Say goodbye to manual setups and hello to instant productivity!

## 📖 Table of Contents

- [🚀 Features at a Glance](#-features-at-a-glance)
  - [💻 Development Essentials](#-development-essentials)
  - [🐚 Shell & Terminal Power-Ups](#-shell--terminal-power-ups)
  - [✍️ Editors & IDEs](#️-editors--ides)
  - [🛠️ System & Desktop Utilities](#️-system--desktop-utilities)
- [🚀 Getting Started](#-getting-started)
  - [Requirements](#requirements)
  - [Installation Steps](#installation-steps)
- [📂 Architecture & Project Structure](#-architecture--project-structure)
- [🔧 Conventions & Customization](#-conventions--customization)
- [🤝 Contributing](#-contributing)

## 🚀 Features at a Glance

This repository automates the installation and configuration of a wide array of essential tools and applications:

### 💻 Development Essentials

- **Languages**: Node.js (via `fnm`), Python (via `uv`), Go (via `gvm`), PHP, and Ruby.
- **Docker**: Containerization for modern application deployment.
- **AI CLIs**: Tools for interacting with Anthropic's Claude and Google's Gemini models.
- **Cloud CLIs**: `gcloud` CLI for Google Cloud Platform management.

### 🐚 Shell & Terminal Power-Ups

- **`zsh`**: A powerful shell, supercharged with `sheldon` for lightning-fast plugin management.
- **`tmux`**: Boost your terminal productivity with persistent sessions and window management.
- **`git` & Utilities**: Enhanced Git configurations, `gitui`, and fuzzy matching tools.
- **`rg` (Ripgrep) & `fd`**: Blazing-fast search and find tools.
- **Terminal Emulators**: Core terminal configurations and `urxvt` setup.

### ✍️ Editors & IDEs

- **`neovim`**: Built from source and heavily customized for an unparalleled editing experience.

### 🛠️ System & Desktop Utilities

- **`i3` & `rofi`**: My preferred configuration for the i3 tiling window manager and application launcher.
- **Fonts**: Beautiful UI and terminal fonts, including Hack Nerd Font.
- **Desktop Apps**: Slack, ActivityWatch, and other essential desktop utilities.

## 🚀 Getting Started

Ready to transform your development environment? Follow these simple steps:

### Requirements

- A fresh or existing Ubuntu LTS installation.
- `git` installed to clone the repository.
- `make` (optional, for convenience).

### Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/phux/.dotfiles.git
   cd .dotfiles
   ```

2. **Run the full installation:**

   This command will execute all installation phases sequentially, installing packages and applying your dotfiles using GNU Stow.

   ```bash
   make
   # or
   ./install.sh
   ```

3. **Run a specific phase (optional):**

   If you only want to apply symlinks or install specific tools, you can run individual scripts instead of the full installer:

   ```bash
   # Apply dotfiles only (stow symlinks)
   make stow

   # Install just development tools
   make dev

   # Check the result
   make verify
   ```

## 📂 Architecture & Project Structure

This project uses a clean, three-layer system to keep everything organized and idempotent:

1. **`install.sh`** — The main entry point. Iterates and executes all scripts in `scripts/` sequentially.
2. **`lib/helpers.sh`** — Shared, idempotent helper functions (e.g., `install_packages`, `clone_or_update_repo`, formatting tools) to prevent raw apt/echo usage.
3. **`scripts/`** — Numbered phases executed in order:
   - `00-core.sh` — Sudo keepalive, apt update, base dependencies.
   - `01-stow.sh` — Symlinks all packages in `stow/` to your home directory using GNU Stow with backup-based conflict resolution.
   - `02-shell.sh` — Zsh, tmux, CLI tools, sheldon, TPM.
   - `03-dev-tools.sh` — Languages, Docker, neovim from source, AI CLIs.
   - `04-desktop.sh` — i3, rofi, desktop apps, ActivityWatch, Slack.
   - `05-fonts.sh` — Hack Nerd Font installation.
   - `06-verify.sh` — Checks core binaries, broken symlinks, and Docker group membership.

**`stow/`** — Each subdirectory is a Stow package mirroring your home directory `~`. All packages are applied at once via `stow --no-folding -t ~ -d ./stow */`.

Stow runs with `--no-folding`: it links each file and never a whole directory. Apps write their state (for example `~/.config/composer/vendor`) next to the links, outside this repository. A new file in `stow/` has no link until you run `make stow`.

**Git** — The repo supplies the shared git settings in `~/.config/git/config` and the global ignore file `~/.config/git/ignore`. `~/.gitconfig` is local and not tracked. Set the identity once with `git config --global user.name` and `git config --global user.email`.

**Secret scan** — This repo is public. `make stow` sets `core.hooksPath` to `.githooks`, and the `pre-commit` hook runs `gitleaks` on the staged changes. `make shell` installs a pinned `gitleaks` release. Until then, a commit fails with a message. `git commit --no-verify` skips the hook.

## 🔧 Conventions & Customization

These dotfiles are designed to be flexible and safe to re-run!

- **Idempotency**: All scripts must be safe to re-run. Use helper functions like `pkg_installed` and `clone_or_update_repo` rather than raw install commands.
- **Adding Configurations**: New tool configurations go in `stow/<toolname>/` mirroring the home directory path (e.g., `stow/foo/.config/foo/config`).
- **Extending Installation**: New installation phases get a new numbered script in `scripts/`. Always use helper functions from `lib/helpers.sh` for logging and package management.

## 🤝 Contributing

While these are personal dotfiles, I welcome suggestions and improvements! If you have ideas for enhancements or find issues, feel free to open an issue or submit a pull request. Let's make our development environments even better together!
