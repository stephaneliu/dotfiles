#!/usr/bin/env bash
# Install zellij plugins by downloading WASM files from GitHub releases

set -euo pipefail

PLUGIN_DIR="$HOME/.config/zellij/plugins"

mkdir -p "$PLUGIN_DIR"

echo "Installing zellij plugins to $PLUGIN_DIR..."

# zjstatus - configurable status bar
echo "Downloading zjstatus.wasm..."
curl -sL "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" \
  -o "$PLUGIN_DIR/zjstatus.wasm"

# room - fuzzy tab search
echo "Downloading room.wasm..."
curl -sL "https://github.com/rvcas/room/releases/latest/download/room.wasm" \
  -o "$PLUGIN_DIR/room.wasm"

# zellij-autolock - auto-lock when in vim/editor
echo "Downloading zellij-autolock.wasm..."
curl -sL "https://github.com/fresh2dev/zellij-autolock/releases/latest/download/zellij-autolock.wasm" \
  -o "$PLUGIN_DIR/zellij-autolock.wasm"

# zellij-forgot - keybind reference
echo "Downloading zellij_forgot.wasm..."
curl -sL "https://github.com/karimould/zellij-forgot/releases/latest/download/zellij_forgot.wasm" \
  -o "$PLUGIN_DIR/zellij_forgot.wasm"

echo "Done! Plugins installed:"
ls -lh "$PLUGIN_DIR"/*.wasm
