#!/usr/bin/env bash
set -eu
set -o pipefail

prj=$(find ~/.config/tmuxinator -exec basename {} \; | sort | uniq  | cut -f 1 -d '.'| fzf)

tmuxinator start "$prj" --suppress-tmux-version-warning=SUPPRESS-TMUX-VERSION-WARNING &>/dev/null disown
