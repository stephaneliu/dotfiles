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
   :CtagsRegen
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

## Plugins installation

Prettier
```
# Ruby
yarn add --dev prettier @prettier/plugin-ruby

# JS
yarn add prettier --dev --extract
```
