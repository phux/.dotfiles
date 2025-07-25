#!/bin/zsh

SCREENSHOT_DIR="$HOME/tmp/screenshots"
FILE="$SCREENSHOT_DIR/screenshot_$(date '+%Y-%m-%d_at_%H-%M-%S').png"
import $FILE
pcmanfm "$SCREENSHOT_DIR"
