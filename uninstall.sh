#!/usr/bin/env bash
# Uninstaller for opencode-refresh
set -euo pipefail

BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
APP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"

echo "==> Uninstalling OpenCode Refresh..."

rm -f "$BIN_DIR/opencode-refresh"
rm -f "$BIN_DIR/opencode-refresh-gui"
rm -f "$APP_DIR/opencode-refresh.desktop"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
fi

echo "✔ Successfully uninstalled."
