# Claude Code configuration

Portable Claude Code setup. `rcup` links these files into `~/.claude`
file-by-file, so Claude's runtime state (`projects/`, `history.jsonl`,
`sessions/`, `plugins/cache/`) stays out of the repo.

## Layout

| Path | Linked to | Notes |
| --- | --- | --- |
| `settings.json` | `~/.claude/settings.json` | Model, hooks, statusline, plugin roster, permissions |
| `settings.local.json` | `~/.claude/settings.local.json` | **Copied**, not linked — Claude rewrites it in place |
| `statusline-command.sh` | `~/.claude/statusline-command.sh` | Context/token statusline |
| `skills/` | `~/.claude/skills/` | Generic skills only |
| `bootstrap/` | *(not linked)* | Data for `bin/claude-setup` |

## Bootstrap

`bin/claude-setup` handles what rcm cannot — things that live in Claude's own
state rather than on disk as config:

- installs Claude Code if missing (it ships outside Homebrew)
- registers plugin marketplaces from `bootstrap/plugins.json`
- installs enabled plugins
- adds MCP servers from `bootstrap/mcp-servers.json`

It is idempotent and runs automatically from `install`. MCP servers
authenticate on first use — run `/mcp` in Claude to sign in.

## Public vs private

This repo is public, so it holds only config that is safe to publish.
Employer-specific configuration lives in a separate private repo: the global
`CLAUDE.md`, work skills, internal plugin marketplaces, and permission entries
naming internal repos and tooling. Some of it contains credentials, so it must
stay out of this repo.

Point `CLAUDE_PRIVATE_CONFIG` at that repo and `claude-setup` will clone it to
`~/.claude-private` and symlink its `CLAUDE.md` and `skills/` into `~/.claude`:

```sh
CLAUDE_PRIVATE_CONFIG=git@github.com:you/claude-private.git claude-setup
```

## Not tracked

Credentials (`~/.claude/.credentials.json`) never belong here — sign in with
`claude` on a new machine instead.
