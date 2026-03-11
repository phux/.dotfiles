#!/bin/bash

# Path to the screensaver images
SCREENSAVER_DIR="$HOME/Dropbox/screensaver"

# Check if the directory exists and has files
if [[ -d "$SCREENSAVER_DIR" ]] && [[ -n $(ls -A "$SCREENSAVER_DIR" 2>/dev/null) ]]; then
    IMAGE=$(find "$SCREENSAVER_DIR" -type f | shuf -n 1)
    i3lock -p default -f -t -i "$IMAGE"
else
    # Fallback to a plain dark color if no images are found
    i3lock -p default -f -c 282828
fi
