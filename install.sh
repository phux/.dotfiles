#!/usr/bin/env bash
set -e

# ANSI Colors
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}   Dotfiles Installation & Migration Runner         ${NC}"
echo -e "${CYAN}====================================================${NC}"

# Ensure we're in the script directory
cd "$(dirname "$0")" || exit 1

if [ ! -f "lib/helpers.sh" ]; then
    echo "Error: lib/helpers.sh not found! Are you running this from the repository root?"
    exit 1
fi

source lib/helpers.sh

# Determine which scripts to run
if [ "$#" -gt 0 ]; then
    SCRIPTS=()
    for arg in "$@"; do
        if [ -f "scripts/${arg}.sh" ]; then
            SCRIPTS+=("scripts/${arg}.sh")
        else
            print_warning "Script scripts/${arg}.sh not found. Skipping."
        fi
    done
else
    SCRIPTS=(scripts/*.sh)
fi

# Run core scripts in sequence
for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        print_info "Executing $script..."
        bash "$script"
    else
        print_warning "Skipping $script (not found)."
    fi
done

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}   Installation Complete!                           ${NC}"
echo -e "${CYAN}   Please restart your terminal/session.            ${NC}"
echo -e "${CYAN}====================================================${NC}"
