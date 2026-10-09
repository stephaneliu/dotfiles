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

The Omarchy shell clock uses 12-hour time with AM/PM, keeping the weekday
visible. Its configuration is tracked in `tag-omarchy/config/omarchy/shell.json`
and hot-reloads when changed.

The profile also loads Bash Git shortcuts from `bash/git.sh`: `gci` commits,
`ga` adds, `gco` checks out, `gps` pushes, `gpl` pulls, and `g` shows status
when called without arguments. `ga .` and `gcln` preserve the exclusions from
the macOS shortcuts. Git subcommand aliases (such as `git st`) must already
be configured. Start a new shell or run `source ~/.bashrc` after installing.

Common Bash shortcuts in `bash/shortcuts.sh` match the existing Zsh shortcuts
where applicable: `l`/`ll` list file details including hidden files, `la`
lists names including hidden files, `q`/`:q` exit the shell, and `gg` clears
the screen. `..`, `...`, and `....` move up one, two, or three directories;
`md` creates directories with `mkdir -p`. Listings use `eza` when installed
and standard `ls` otherwise. Omarchy's existing `ls` and tool aliases remain
available.

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

#### Capturing Omarchy customizations

Keep Omarchy's defaults upstream and version personal overrides with the
existing rcm profile. Files under `/usr/share/omarchy` belong to Omarchy;
customizations belong in the user configuration. See the
[official dotfiles guide](https://github.com/omacom/omarchy/blob/quattro/manual/31-dotfiles.md).

- Track individual customized files under `tag-omarchy`, keeping the live
  directories available for Omarchy's other files. Add `bindings.lua`,
  `looknfeel.lua`, and `autostart.lua` under `config/hypr/` as needed.
- Preserve imports of Omarchy's defaults, then apply personal settings.
  Follow the existing `config/hypr/input.lua` override and `bashrc`, which
  loads Omarchy's shell defaults before personal additions.
- Keep monitor names, scaling, device settings, and host-specific paths in
  an explicitly selected machine profile or an ignored local file. Ensure
  any local file is loaded by the relevant configuration.
- Track authored custom themes under `config/omarchy/themes/<name>/` and
  executable hooks under `config/omarchy/hooks/<event>.d/`. Leave generated
  current-theme output out of Git. See the
  [theme guide](https://omarchy.org/manual/making-your-own-theme/).
- Document extra packages, fonts, services, and manual setup steps. Keep any
  Omarchy bootstrap separate from the macOS `install` script.
- Exclude backup files such as `*.bak.*`, caches, logs, histories,
  credentials, and downloaded artifacts from commits.

Before capturing a customization, compare the live file with its shipped
template under `/usr/share/omarchy/config/` to identify intentional changes.
Back up the live file before replacing it with an rcm link. Preview and apply
using the explicit Omarchy profile, validate Hyprland changes, and review
the diff before committing:

```sh
RCRC="$HOME/.dotfiles/rcrc.omarchy" lsrc
RCRC="$HOME/.dotfiles/rcrc.omarchy" rcup -v
hyprctl reload
hyprctl configerrors
git -C "$HOME/.dotfiles" diff -- tag-omarchy
```

**Config resets can overwrite tracked files through symlinks.** The installed
`omarchy-refresh-config` implementation uses `cp -f`, which can follow a
config symlink and overwrite its target inside this repository. Commit
customizations before resetting a tracked config, then inspect the Git diff
afterward. Git provides the recovery record; a symlink does not protect the
customization from being overwritten.

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
