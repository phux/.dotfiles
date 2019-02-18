#!/usr/bin/env bash
set -eu
set -o pipefail

prj=$(find ~/.config/tmuxinator -execdir sh -c 'printf "%s\n" $(basename "${0%.*}")' {} ';' | sort | uniq | nl | fzf | cut -f 2)

tmuxinator start "$prj"
