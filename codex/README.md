# Codex preferences

`config.toml` contains public preferences only. Keep credentials, project paths,
trust decisions, saved approvals, MCP environment values, and generated app state
in the local `~/.codex/config.toml`. Do not copy that file back into this repository.

Run `bin/codex-setup --check` to validate, then `bin/codex-setup` to apply.
Python 3.11 or newer is required. `CODEX_HOME` is honored; `--config PATH` can select
another destination. The main dotfiles installer also runs this command.

The setup command updates only keys present in the template, preserves all other
settings, and refuses layouts it cannot safely merge. Changed configs receive a
mode-0600 backup alongside the live file. Backups may contain secrets: keep them
local. Removing a preference from the template does not delete its local value.

rcm excludes this directory so it cannot replace the live configuration with a
symlink or overwrite local state. Review additions to the template before commit.
Never add auth files, sessions, logs, memories, or the whole Codex home directory.
