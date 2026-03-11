#!/usr/bin/env bash
source ./lib/helpers.sh

print_info "Phase 01: Symlinking dotfiles using GNU Stow"

# Ensure common target directories exist
ensure_dir "$HOME/.config"
ensure_dir "$HOME/.local/bin"
ensure_dir "$HOME/.local/share"
ensure_dir "$HOME/tools"
ensure_dir "$HOME/tmp/screenshots"
ensure_dir "$HOME/.gemini"
ensure_dir "$HOME/.config/opencode"
ensure_dir "$HOME/.claude"
ensure_dir "$HOME/.tmux"

STOW_DIR="$(pwd)/stow"

if [ ! -d "$STOW_DIR" ]; then
    print_error "Stow directory $STOW_DIR does not exist!"
    exit 1
fi

cd "$STOW_DIR" || exit 1

# Automatically resolve stow conflicts by backing up existing files
MAX_ATTEMPTS=5
ATTEMPT=1
while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    # Run stow in simulation mode and capture warnings about existing targets
    CONFLICTS=$(stow -n -v -t "$HOME" -d "$STOW_DIR" */ 2>&1 | awk -F': ' '/\* existing target/ {print $2}')
    
    if [ -z "$CONFLICTS" ]; then
        break # No more conflicts
    fi

    print_info "Found existing files conflicting with stow. Backing them up (Attempt $ATTEMPT)..."
    TIMESTAMP=$(date +%Y%m%d%H%M%S)
    
    # Read conflicts line by line
    while IFS= read -r conflict_file; do
        if [ -n "$conflict_file" ]; then
            TARGET="$HOME/$conflict_file"
            if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
                BACKUP="${TARGET}.backup-${TIMESTAMP}"
                mv "$TARGET" "$BACKUP"
                print_info "Backed up: $TARGET -> $BACKUP"
            fi
        fi
    done <<< "$CONFLICTS"
    
    ATTEMPT=$((ATTEMPT + 1))
done

if [ $ATTEMPT -gt $MAX_ATTEMPTS ]; then
    print_error "Failed to resolve all stow conflicts after $MAX_ATTEMPTS attempts."
    exit 1
fi

# Perform the actual stow
stow -t "$HOME" -d "$STOW_DIR" */
print_success "Phase 01: Stow completed"
