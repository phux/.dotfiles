#!/bin/bash

# This script checks for the latest versions of tools and updates the vars.yml file.

set -euo pipefail

echo "Starting version update..."

VARS_FILE="group_vars/all/vars.yml"

# Define the mapping between the variable names in vars.yml and their GitHub repositories.
REPOS=(
  # "node_version:nodejs/node"
  "activitywatch_version:ActivityWatch/activitywatch"
  "firacode_version:tonsky/FiraCode"
  "go_mockery_version:vektra/mockery"
  "go_golangcilint_version:golangci/golangci-lint"
  # "ruby_version:ruby/ruby"
  "rbenv_version:rbenv/rbenv"
  "bat_version:sharkdp/bat"
  "rg_version:BurntSushi/ripgrep"
  "tmux_version:tmux/tmux"
  "hack_font_version:source-foundry/Hack"
  "fnm_version:Schniz/fnm"
  # "neovim_version:neovim/neovim"
)

for repo_info in "${REPOS[@]}"; do
  VAR_NAME="${repo_info%%:*}"
  REPO="${repo_info#*:}"

  LATEST_VERSION=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"tag_name": "v?([^"]+)".*/\1/')

  CURRENT_VERSION=$(grep "^$VAR_NAME:" "$VARS_FILE" | sed -E 's/^[^:]+: v?(.*)/\1/')

  if [[ -n "$LATEST_VERSION" ]]; then
    if [[ "$LATEST_VERSION" != "$CURRENT_VERSION" ]]; then
      echo "Updated $REPO from $CURRENT_VERSION to $LATEST_VERSION"
      if [[ "$VAR_NAME" == "rg_version" ]]; then
        sed -i "s/^$VAR_NAME: .*/$VAR_NAME: $LATEST_VERSION/" "$VARS_FILE"
      else
        sed -i "s/^$VAR_NAME: .*/$VAR_NAME: v$LATEST_VERSION/" "$VARS_FILE"
      fi
    else
      echo "No new version for $REPO. Current version is $LATEST_VERSION"
    fi
  else
    echo "Could not determine latest version for $REPO"
  fi
done

echo "Version update complete."

