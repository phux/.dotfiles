# ✨ My Awesome Dotfiles ✨

Welcome to my personal dotfiles repository! 🎉 This collection is designed to streamline and automate the setup of my development environment across various machines, all powered by [Ansible](https://www.ansible.com/).

These dotfiles are more than just configuration files; they are the blueprint for a consistent, efficient, and delightful computing experience. Say goodbye to manual setups and hello to instant productivity!

## 🚀 Features at a Glance

This repository automates the installation and configuration of a wide array of essential tools and applications, ensuring you have everything you need right out of the box. Here's a peek at what's included:

### 💻 Development Essentials

- **`pip`**: Python package installer for all your Pythonic needs.
- **`rbenv` & `ruby`**: Seamless Ruby version management and installation.
- **`nvm` & `node`**: Effortless Node.js version management and setup.
- **`gvm` & `go`**: Go version management for robust Go development.
- **`composer`**: The indispensable dependency manager for PHP projects.
- **`pyenv`**: Manage multiple Python versions with ease.
- **`tfenv`**: Keep your Terraform versions organized and switch between them effortlessly.
- **`docker`**: Get up and running with containerization for modern application deployment.
- **`php` & `golang` linters**: Maintain high code quality with integrated linting for PHP and Go.

### 🐚 Shell & Terminal Power-Ups

- **`zsh`**: A powerful shell, supercharged with `antibody` for lightning-fast plugin management.
- **`tmux`**: Boost your terminal productivity with persistent sessions and window management.
- **`git`**: Enhanced Git configurations, including `delta` for beautiful diffs, `git-fuzzy` for fuzzy finding, and `gitui` for a terminal UI.
- **`rg` (Ripgrep)**: Blazing-fast recursive line-oriented search tool.
- **`fd`**: A user-friendly and incredibly fast alternative to the `find` command.
- **`terminal`**: Core terminal configurations, including Xresources for a personalized look and feel.
- **`urxvt`**: Fine-tuned configurations for the rxvt-unicode terminal emulator.

### ✍️ Editors & IDEs

- **`neovim`**: A highly customized Neovim setup, packed with plugins and configurations for an unparalleled editing experience (linters, beautiful color schemes, and more!).
- **`gemini-cli`**: Specific configurations for the Gemini CLI, enhancing your command-line interactions.

### 🛠️ System & Desktop Utilities

- **`common`**: Foundational system configurations, including `rofi` for a sleek application launcher and refined `sudo` settings.
- **`font`**: Ensures you have all the necessary fonts for a visually appealing terminal and UI.
- **`i3`**: My preferred configuration for the i3 tiling window manager, maximizing screen real estate and workflow efficiency.
- **`keepassxc`**: Secure and convenient password management integration.
- **`mysql`**: Essential MySQL client configurations for database interactions.
- **`nix`**: Configurations for the powerful Nix package manager.
- **`pandoc`**: Streamlined document conversion setups.
- **`pkg_manager`**: Automated package manager configurations (e.g., `apt` for Debian/Ubuntu-based systems).
- **`zip`**: Handy configurations for archive management.

## 🚀 Getting Started

Ready to transform your development environment? Follow these simple steps:

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/phux/.dotfiles.git
    cd .dotfiles
    ```

2.  **Install Ansible and dependencies:**

    ```bash
    make
    ```

    This command will install Ansible and any other necessary dependencies to run the playbooks on your system.

3.  **Install on localhost (use with caution!):**

    This step will apply all the configurations directly to your current machine. **Please be aware that this process will overwrite your existing configuration files, and no automatic backup is made. It's highly recommended to back up your current dotfiles before proceeding.**

    ```bash
    make provision
    ```

## 🔧 Customization

These dotfiles are designed to be flexible! Feel free to tailor them to your unique preferences:

- **Variables:** Adjust global settings by modifying the variables in `group_vars/all/vars.yml`.
- **Roles:** Dive into the `roles/` directory to understand how each application is configured. You can easily enable, disable, or modify specific tasks within these roles to suit your needs.

## 🤝 Contributing

While these are personal dotfiles, I welcome suggestions and improvements! If you have ideas for enhancements or find issues, feel free to open an issue or submit a pull request. Let's make our development environments even better together!

---
