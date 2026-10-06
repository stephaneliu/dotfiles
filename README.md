# Dotfiles

Dotfiles managed with [rcm][1]

## Install

```
git clone https://github.com/stephaneliu/dotfiles.git ~/.dofiles
~/.dotfiles/install
```

## Running rcm manually

> RCRC=~/.dotfiles/rcrc rcup -v

The default `rcrc` and `install` script are for macOS.

### Omarchy profile

Install rcm (the `rcm` AUR package on Arch), then preview and apply:

```sh
RCRC="$HOME/.dotfiles/rcrc.omarchy" lsrc
RCRC="$HOME/.dotfiles/rcrc.omarchy" rcup -v
hyprctl reload
hyprctl configerrors
```

This profile installs only the overrides in `tag-omarchy`, leaving Omarchy's
other configuration files in place. Caps Lock types backtick, and Shift + Caps
Lock types tilde, using a US keyboard layout. rcm prompts before replacing
existing files; keep a backup of any local changes before replacing them.

The profile also loads Bash Git shortcuts from `bash/git.sh`: `gci` commits,
`ga` adds, `gco` checks out, `gps` pushes, `gpl` pulls, and `g` shows status
when called without arguments. `ga .` and `gcln` preserve the exclusions from
the macOS shortcuts. Git subcommand aliases (such as `git st`) must already
be configured. Start a new shell or run `source ~/.bashrc` after installing.

Bash uses vi command-line editing (`Esc`, `jk`, or `kj` enters command mode).
In command mode, `k`/`j` searches older/newer history matches for the typed text
anywhere in a command, matching the macOS history substring search. Up/Down
also searches matches. With an empty line, `k`/`j` cycles through all history.
History syncs between panes after each command. Ctrl+R keeps Omarchy's fzf
history picker.

To add an override, place it under `tag-omarchy` using its home-relative path
without the leading dot (for example, `config/hypr/bindings.lua`). Use the
explicit `RCRC` command above when updating Omarchy; the macOS `rcup` shell
alias selects the default profile.

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
