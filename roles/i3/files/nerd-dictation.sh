#!/bin/bash

# --- CONFIGURATION ---
ND_PATH="$HOME/tools/nerd-dictation"

# 1. Set Default Model to "en_small" if no argument is provided
MODEL_NAME="${1:-en_small}"
MODEL_PATH="$ND_PATH/$MODEL_NAME"

# 2. Define Audio Devices in Priority Order
# (Bash array allows easy iteration)
DEVICES=(
  "alsa_input.usb-BLUE_MICROPHONE_Blue_Snowball_SUGA_2020_09_12_57812-00.mono-fallback"
  "bluez_input.F4_9D_8A_5C_53_52.0"
  "alsa_input.pci-0000_00_1f.3.analog-stereo"
)

# Function to find the first available device from our list
get_active_device() {
  # Get list of currently available sources from PulseAudio/PipeWire
  # We use 'pactl list short sources' to check what's actually plugged in
  AVAILABLE_SOURCES=$(pactl list short sources | awk '{print $2}')

  for dev in "${DEVICES[@]}"; do
    if echo "$AVAILABLE_SOURCES" | grep -q "^$dev$"; then
      echo "$dev"
      return 0
    fi
  done
  return 1 # No preferred devices found
}

# --- LOGIC ---

# Check if nerd-dictation is currently running
if pgrep -f "nerd-dictation begin" >/dev/null; then
  # --- STOPPING ---
  notify-send -t 2000 "Dictation" "Stopped..."
  cd "$ND_PATH"
  $HOME/tools/nerd-dictation/.venv/bin/python $HOME/tools/nerd-dictation/nerd-dictation end

else
  # --- STARTING ---

  # Verify Model Exists
  if [ ! -d "$MODEL_PATH" ]; then
    notify-send -u critical "Dictation Error" "Model '$MODEL_NAME' not found!"
    exit 1
  fi

  # Select Audio Device
  SELECTED_DEVICE=$(get_active_device)

  if [ -z "$SELECTED_DEVICE" ]; then
    # Fallback: If none of your specific devices are found, let nerd-dictation pick default
    DEVICE_FLAG=""
    DEV_MSG="System Default"
  else
    DEVICE_FLAG="--pulse-device-name=$SELECTED_DEVICE"
    # Create a short friendly name for notification
    # This extracts a recognizable part of the string (e.g. 'BLUE_MICROPHONE' or 'F4_9D...')
    DEV_MSG=$(echo "$SELECTED_DEVICE" | grep -oE "BLUE_[^.]+|[0-9A-F]{2}_[0-9A-F]{2}|analog-stereo")
  fi

  # NOTIFY LOADING FIRST
  notify-send -t 5000 "Dictation" "⏳ Loading Model ($MODEL_NAME)..."

  cd "$ND_PATH" || exit

  # Start the process
  $HOME/tools/nerd-dictation/.venv/bin/python $HOME/tools/nerd-dictation/nerd-dictation begin --full-sentence --vosk-model-dir="$MODEL_PATH" $DEVICE_FLAG &

  # If using a large model, wait a few seconds before saying "Ready"
  # Adjust this sleep based on your manual test!
  if [[ "$MODEL_NAME" == *"large"* ]] || [[ "$MODEL_NAME" == *"giga"* ]] || [[ "$MODEL_NAME" == *"0.22"* ]]; then
    sleep 5
  fi

  # NOW notify that we are actually listening
  notify-send -t 2000 "Dictation" "🔴 GO! ($DEV_MSG)"
fi
