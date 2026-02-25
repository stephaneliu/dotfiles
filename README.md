# Dotfiles

Dotfiles managed with [rcm][1]

## Install

```
git clone https://github.com/stephaneliu/dotfiles.git ~/.dofiles
~/.dotfiles/install
```

## Running rcm manually

> RCRC=~/.dotfiles/rcrc rcup -v

[1]:https://github.com/thoughtbot/rcm

## Neovim Class Navigation

Jump to Ruby class and React component definitions using ctags (no LSP required).

### Setup

1. Install universal-ctags:
   ```
   brew bundle
   ```

2. Generate tags in your project:
   ```
   :CtagsRegen      " project only
   :CtagsRegen!     " include bundled gems (requires bundle install on host)
   ```

3. (Optional) Install pre-commit hook for automatic tag regeneration:
   ```
   :CtagsInstallHook
   ```

### Usage

| Keymap | Filetype | Description |
|--------|----------|-------------|
| `gd` | ruby, tsx, jsx | Jump to class/component definition under cursor |
| `<leader>gc` | any | Fuzzy search all classes and modules |

**Examples:**
- Cursor on `UserService` → press `gd` → jumps to `app/services/user_service.rb`
- Cursor on `Admin::UsersController` → press `gd` → jumps to `app/controllers/admin/users_controller.rb`
- Press `<leader>gc` → type partial class name → select from picker

**Notes:**
- Tags file stored at `.tags` in project root (add to `.gitignore`)
- Works with Docker volume-mounted code (no LSP dependency)
- Multiple matches open a Telescope picker to choose

## Zellij

Terminal multiplexer with tmux-style keybindings.

### Install

```bash
brew install zellij
~/.dotfiles/bin/install-zellij-plugins.sh
```

### Keybindings

Uses `Ctrl+a` as the prefix (tmux-style).

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate panes (auto-locks in neovim) |
| `Ctrl+a \|` | Split right |
| `Ctrl+a -` | Split down |
| `Ctrl+a z` | Zoom pane |
| `Ctrl+a x` | Close pane |
| `Ctrl+a r` | Resize mode (`hjkl` grow, `HJKL` shrink) |
| `Ctrl+a c` | New tab |
| `Ctrl+a n/p` | Next/previous tab |
| `Ctrl+a 1-9` | Go to tab |
| `Ctrl+a ,` | Rename tab |
| `Ctrl+a [` | Scroll mode (`/` search, `e` edit in $EDITOR) |
| `Ctrl+a d` | Detach |
| `Ctrl+a w` | Session picker |
| `Ctrl+a f` | Toggle floating panes |
| `Ctrl+a F` | New floating pane |
| `Ctrl+a m` | Move mode (`hjkl` to reposition) |
| `Ctrl+a Ctrl+a` | Toggle last tab |
| `Ctrl+Space` | Room (fuzzy tab search) |
| `Ctrl+y` | Harpoon (quick pane navigation) |
| `Alt+/` | Keybind reference |
| `Alt+z` | Toggle lock mode |

### Plugins

Installed by `bin/install-zellij-plugins.sh`:
- **zjstatus** - configurable status bar
- **room** - fuzzy tab search
- **zellij-autolock** - auto-lock when in vim/neovim/fzf
- **zellij-forgot** - keybind reference popup

**Note:** Harpoon requires building from source with Rust:
```bash
git clone https://github.com/Nacho114/harpoon.git /tmp/harpoon
cd /tmp/harpoon
rustup target add wasm32-wasip1
cargo build --release --target wasm32-wasip1
cp target/wasm32-wasip1/release/harpoon.wasm ~/.config/zellij/plugins/
```

### Claude Code Status

Displays Claude Code activity in the zjstatus bar across multiple panes/tabs.

```bash
claude plugin marketplace add https://github.com/thoo/claude-code-zellij-status.git
claude plugin install cc-zjstatus
```

**Symbols:**
| Symbol | Meaning |
|--------|---------|
| `●` | Working |
| `◐` | Thinking |
| `✎` | Writing file |
| `⚡` | Bash execution |
| `?` | Awaiting input |
| `⚠` | Permission request |

## Ghostty

Terminal emulator configured to work with Zellij.

### Install

```bash
brew install --cask ghostty
```

### Configuration

Ghostty unbinds `Ctrl+a` so Zellij receives it as the prefix key. Use:
- `Ctrl+Shift+,` - Open config
- `Ctrl+Shift+r` - Reload config

Tabs and splits are managed by Zellij, not Ghostty.

## Raycast

Script commands for Raycast.

### Install

Add the script commands directory to Raycast:

1. Open Raycast Settings (`⌘,`)
2. Go to **Extensions → Script Commands**
3. Click **Add Directories**
4. Select `~/.dotfiles/config/raycast/script-commands`

### Commands

| Command | Description |
|---------|-------------|
| Toggle terminal-notifier Style | Switch notification style between Banners (temporary) and Alerts (persistent) |

**Note:** The toggle command requires Accessibility permissions for Raycast (System Settings → Privacy & Security → Accessibility).

## Plugins installation

Prettier
```
# Ruby
yarn add --dev prettier @prettier/plugin-ruby

# JS
yarn add prettier --dev --extract
```
