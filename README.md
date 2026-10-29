# OpenCode Refresh 🔄

> Perform a 100% clean reinstall/refresh of [OpenCode](https://github.com/anomalyco/opencode) on Arch Linux while **safely preserving only your chat history, sessions, and messages**.

---

## ⚡ The Problem

Over time, OpenCode installations accumulate old auth tokens, stale cache files, temporary workspaces, snapshots, and bloated state directories. Sometimes a fresh start is necessary to clear glitches or reset settings.

However, uninstalling or clearing data directories normally wipes all of your past conversations and prompts.

`opencode-refresh` solves this with a single command or desktop shortcut:
1. **Backs up** your chat history into a timestamped SQLite archive.
2. **Wipes** all stale config, cache, state, snapshots, and credentials.
3. **Reinstalls** `opencode` cleanly via `pacman` (without upgrading your entire system!).
4. **Restores** only your chat history (`sessions`, `messages`, `parts`, `projects`) into a pristine database.

---

## ✨ Features

- **Safe by Default:** Automatically takes a full SQLite snapshot with `PRAGMA integrity_check` before anything is modified.
- **Fast:** Only refreshes the `opencode` package (`pacman -S --noconfirm opencode`), avoiding unnecessary full-system upgrades.
- **Preserves Chat History:**
  - ✅ Sessions (`session`, `session_v2`, `session_inbox`, `session_message`, `session_pending`)
  - ✅ Messages & parts (`message`, `part`, `todo`)
  - ✅ Projects & worktrees (`project`, `project_directory`, `worktree`, `workspace`)
- **Strips Stale Bloat & Sensitive Data:**
  - ❌ Authentication & account credentials (`account`, `credential`, `auth.json`)
  - ❌ Cache & temp data (`~/.cache/opencode`, `~/.local/state/opencode`)
  - ❌ Corrupted configs or stale KV entries (`~/.config/opencode`, `kv`)
- **Desktop Launcher Included:** Comes with an Arch Linux `.desktop` entry to search and run directly from Rofi, Wofi, KDE, or GNOME application menus.

---

## 📦 Installation

### Quick Install (Git Clone)

```bash
git clone https://github.com/Rocketkid300/opencode-refresh.git
cd opencode-refresh
./install.sh
```

---

## 🚀 How to Use

### 1. From Terminal
Just run:
```bash
opencode-refresh
```
It will display the proposed actions and current table counts, asking for your confirmation (`yes`) before making any changes.

### 2. From Application Launcher
Search for **OpenCode Refresh** in your application launcher (Rofi, Wofi, KDE Application Launcher, GNOME, etc.).
A terminal window will pop up, perform the backup, prompt for sudo password to refresh the package, restore the chat history, and pause so you can review the results.

---

## 💾 Backup Location

Backups are timestamped and preserved indefinitely under:
```
~/opencode-refresh-backups/YYYYMMDD-HHMMSS/
```
Inside each backup folder:
- `opencode.db.full`: Complete byte-for-byte snapshot of your database before the refresh.
- `opencode.db.history`: The sanitized history-only database used for restoration.

---

## 🗑️ Uninstallation

To remove `opencode-refresh` and its desktop launcher:
```bash
./uninstall.sh
```

---

## 📄 License

MIT © [Rocketkid300](https://github.com/Rocketkid300)
