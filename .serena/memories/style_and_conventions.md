## Code Style and Conventions

*   **Ansible Conventions:** Follows standard Ansible best practices for role structure and variable management.
*   **YAML:** Assumed standard Ansible YAML conventions.

## General Guidelines

*   **Automation and Consistency:** The primary goal is to automate and maintain consistency across development environments.
*   **Customization:** Highly customizable through `group_vars/all/vars.yml` for global settings and by modifying tasks within individual `roles/`.
*   **Backup Warning:** `make provision` overwrites existing configuration files; users are advised to back up their dotfiles before proceeding.