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

# harpoon - quick pane navigation (requires Rust build from source)
if command -v cargo &> /dev/null; then
  echo "Building harpoon.wasm from source..."
  HARPOON_TMP="/tmp/harpoon-build-$$"
  git clone --quiet https://github.com/Nacho114/harpoon.git "$HARPOON_TMP"
  cd "$HARPOON_TMP"
  rustup target add wasm32-wasip1 2>/dev/null || true
  cargo build --release --target wasm32-wasip1 --quiet
  cp target/wasm32-wasip1/release/harpoon.wasm "$PLUGIN_DIR/"
  cd - > /dev/null
  rm -rf "$HARPOON_TMP"
  echo "harpoon.wasm built successfully"
else
  echo "Warning: cargo not found, skipping harpoon build"
  echo "Install Rust to build harpoon: https://rustup.rs"
fi

echo "Done! Plugins installed:"
ls -lh "$PLUGIN_DIR"/*.wasm
