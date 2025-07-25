# My Dotfiles

Welcome to my personal dotfiles repository! This repository contains my configuration files for various tools and applications, managed with [Ansible](https://www.ansible.com/). These dotfiles aim to provide a consistent and efficient development environment across different machines.

## Features

This collection of dotfiles automates the setup and configuration of many essential tools and applications, including:

- **Development Tools:**
    - **`pip`**: Python package installer.
    - **`rbenv` & `ruby`**: Ruby version management and Ruby installation.
    - **`nvm` & `node`**: Node.js version management and Node.js installation.
    - **`gvm` & `go`**: Go version management and Go installation.
    - **`composer`**: PHP dependency manager.
    - **`pyenv`**: Python version management.
    - **`tfenv`**: Terraform version manager.
    - **`docker`**: Containerization platform.
    - **`php` & `golang` linters**: Code quality tools for PHP and Go.

- **Shell & Terminal Enhancements:**
    - **`zsh`**: Configured with `antibody` for plugin management.
    - **`tmux`**: Terminal multiplexer for persistent sessions.
    - **`git`**: Enhanced Git configuration, including `delta`, `git-fuzzy`, and `gitui`.
    - **`rg` (Ripgrep)**: Fast, recursive, grep-like search tool.
    - **`fd`**: A simple, fast and user-friendly alternative to 'find'.
    - **`terminal`**: General terminal configurations (e.g., Xresources).
    - **`urxvt`**: Configuration for the rxvt-unicode terminal emulator.

- **Editors & IDEs:**
    - **`neovim`**: Highly customized Neovim setup with various plugins and configurations (linters, colors, etc.).
    - **`gemini-cli`**: Configuration for the Gemini CLI.

- **System & Desktop Utilities:**
    - **`common`**: Common system configurations, including `rofi` (application launcher) and `sudo` settings.
    - **`font`**: Font installations.
    - **`i3`**: Configuration for the i3 tiling window manager.
    - **`keepassxc`**: Password manager configuration.
    - **`mysql`**: MySQL client configurations.
    - **`nix`**: Nix package manager configurations.
    - **`pandoc`**: Document converter configurations.
    - **`pkg_manager`**: Package manager configurations (e.g., `apt`).
    - **`todotxt`**: Configuration for the todo.txt CLI.
    - **`zip`**: Zip utility configurations.

## Installation

To get started with these dotfiles, follow these steps:

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/phux/.dotfiles.git
    cd .dotfiles
    ```

2.  **Install Ansible and dependencies:**

    ```bash
    make
    ```
    This command will install Ansible and any other necessary dependencies to run the playbooks.

3.  **Choose your installation method:**

    

    -   **Install on localhost (use with caution!):**
        This will apply the configurations directly to your current machine. **Be aware that this will override your existing configuration files, and no backup is made.**

        ```bash
        make provision
        ```

## Customization

You can customize these dotfiles to fit your specific needs:

-   **Variables:** Modify variables in `group_vars/all/vars.yml` to change default settings.
-   **Roles:** Explore the `roles/` directory to understand how different applications are configured. You can enable/disable roles or modify their tasks.

Feel free to fork this repository and adapt it to your own preferences!











