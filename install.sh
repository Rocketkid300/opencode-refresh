#!/usr/bin/env bash
# Installer for opencode-refresh on Arch Linux
set -euo pipefail

BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
APP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing OpenCode Refresh..."

# Check prerequisites
for cmd in pacman sqlite3 opencode; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Warning: '$cmd' was not found on your system."
  fi
done

# Create target directories
mkdir -p "$BIN_DIR" "$APP_DIR"

# Install binaries
echo "Installing scripts to $BIN_DIR..."
install -m 755 "$SCRIPT_DIR/bin/opencode-refresh" "$BIN_DIR/opencode-refresh"
install -m 755 "$SCRIPT_DIR/bin/opencode-refresh-gui" "$BIN_DIR/opencode-refresh-gui"

# Install desktop entry with resolved absolute path
echo "Installing desktop entry to $APP_DIR..."
sed "s|^Exec=.*|Exec=$BIN_DIR/opencode-refresh-gui|" "$SCRIPT_DIR/desktop/opencode-refresh.desktop" > "$APP_DIR/opencode-refresh.desktop"
chmod 644 "$APP_DIR/opencode-refresh.desktop"

# Refresh desktop database if tool is present
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
fi

echo
echo "✔ Installation complete!"
echo
echo "How to use:"
echo "  1. CLI: Run 'opencode-refresh' in any terminal."
echo "  2. App Launcher: Search for 'OpenCode Refresh' in your application launcher."
echo
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo "Note: Make sure '$BIN_DIR' is included in your PATH (e.g. in ~/.zshrc or ~/.bashrc)."
fi
