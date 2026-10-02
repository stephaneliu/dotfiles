---
name: worktree-add-remove
description: Add or remove a git worktree for this repo. On add, first creates a Linear ticket (default team CHE, overridable; prompts for assignee defaulting to the current user, and for the cycle defaulting to the team's current cycle) — or, when the user names an existing ticket, adopts it and moves it to In Progress instead of creating a second one. Always fetches and branches off latest `origin/master`. Infers a category (`features`, `bugfixes`, or `code-reviews`) from the prompt, and places the worktree at `../<category>/<TICKET>-<name>`. Dispatches to `cocam worktree add` (with docker services) or plain `git worktree add` based on a services flag, then copies untracked `.claude/skills/` directories into the new worktree and installs/configures lefthook via `scripts/setup-lefthook.sh` (symlinks the gitignored `lefthook-local.yml` from the main worktree, without which the worktree silently runs no hooks). Finally opens a `herdr` tab rooted in the new worktree within the `cycle` workspace (creating that workspace if absent), with the tab labeled after the ticket identifier (lowercase, e.g. `con-433`). On remove, copies uncommitted files/dirs from the worktree's top-level `docs/` and any untracked `.claude/skills/` directories back to the primary repo, then dispatches to `cocam worktree remove` or `git worktree remove` based on whether the worktree's `.env` contains a `COCAM_*_PORT` key, and finally deletes the local branch (`git branch -d`). Use when the user says "add a worktree", "remove a worktree", "create a worktree", "tear down a worktree", "spin up a worktree".
---

# Worktree add / remove

Workflow for creating and tearing down git worktrees in this repo, with a linked Linear ticket per worktree. Two variants exist:

- **cocam worktree** — wraps `git worktree`, configures dedicated docker services with worktree-specific ports (e.g. `COCAM_RAILS_PORT`), and copies docker volumes from the main worktree. **Path constraint**: `cocam worktree add` only accepts a bare identifier matching `[a-zA-Z0-9_-]+(?:/[a-zA-Z0-9_-]+)*` and always creates the worktree at `../<identifier>` (any `/` in the identifier is collapsed to `-`). To land a cocam worktree under `../<category>/`, you must create it flat and then `git worktree move` it (see Add step 5).
- **plain git worktree** — just a working tree, no services. Accepts any path, so the `../<category>/<TICKET>-<name>` layout works directly.

## Add

**Inputs:**
- `name` (string, required) — name of the worktree. May be a bare name (e.g. `foo`) or a relative/absolute path (e.g. `../debug/foo`). Bare names are placed at `../<category>/<TICKET>-<name>`.
- `services` (boolean, required) — whether the worktree needs its own docker services
- `category` (string, optional) — one of `features`, `bugfixes`, `code-reviews`. Inferred from the prompt; if unclear, ask the user.
- `team` (string, optional) — Linear team identifier. Defaults to `CHE`.
- `assignee` (string, optional) — who the Linear ticket is assigned to. Defaults to the current user; ask if it should go to someone else.
- `cycle` (string, optional) — which Linear cycle the ticket lands in. Defaults to the team's current cycle; ask if it should go elsewhere.

If `name` or `services` is missing, ask the user before proceeding.

**Before starting:** alert the user to run `cocam aws login` — `cocam worktree add` (and the docker volume copy it does for `services == true`) can fail partway through with a stale/missing AWS session, which is harder to untangle than logging in up front. Surface this as a heads-up, don't run it yourself.

**Steps:**

1. **Create a Linear ticket — or adopt an existing one.**

   **If the user named an existing ticket** (e.g. "create a worktree for CON-332", or the supplied `name` already carries a `<TEAM>-<NUM>` prefix): do **not** create a second ticket. Fetch it with `mcp__linear-server__get_issue` to read its title and status, use its identifier for the path, and then **move it to "In Progress"** if it is not already started:

   ```
   mcp__linear-server__save_issue(id: "<TICKET>", state: "In Progress")
   ```

   Spinning up a worktree means work is actually starting, so the board should reflect that at creation time — not later at PR time. Skip the title/description/assignee/cycle prompts below; the ticket already has them. Then continue at step 2.

   **Otherwise, create a new ticket.** Prompt the user for a ticket **title** and an optional **description**. Use team `CHE` by default; if the user has specified a different team, use that.

   **Ask the user who the ticket should be assigned to** — default to the current user, but offer to assign it to someone else. Pass the choice to `save_issue`'s `assignee` param, which accepts `"me"`, a name, an email, or a user ID (use `mcp__linear-server__list_users` if you need to resolve a name).

   **Ask the user which cycle the ticket should go in** — default to the team's **current cycle**, but offer to place it in a different cycle (or none). Pass the choice to `save_issue`'s `cycle` param (cycle name, number, or ID); resolve cycles with `mcp__linear-server__list_cycles` (use `type: current` for the default).

   Use the Linear MCP tools (`mcp__linear-server__save_issue`) to create the issue, passing `team`, `title`, the optional `description`, and the resolved `assignee` and `cycle`. If the Linear MCP server is unavailable, fall back to asking the user to paste the ticket reference manually.

   Capture the returned ticket identifier (e.g. `CHE-27`).

2. **Determine the category.** Infer one of:
   - `features` — signals: "implement", "add", "build", "new", "create", "feature", "endpoint"
   - `bugfixes` — signals: "fix", "bug", "debug", "issue", "regression", "broken", "repro"
   - `code-reviews` — signals: "review", "code review", "PR review", "check this PR"

   If the category is not obvious from the prompt, ask the user to pick one.

3. **Compute the prefixed path.** Prepend the ticket identifier to the **basename** of `name`. If `name` is bare (no `/`), build the path as `../<category>/<TICKET>-<name>`. If `name` already contains a directory portion, preserve it (user-supplied paths override the category convention):
   - `foo` (category: features) → `../features/CHE-27-foo`
   - `bar` (category: bugfixes) → `../bugfixes/CHE-27-bar`
   - `../debug/C29-debug` → `../debug/CHE-27-C29-debug`
   - `/abs/path/foo` → `/abs/path/CHE-27-foo`

   **Category directories are siblings, not nested.** `features`, `bugfixes`, and `code-reviews` all live at the same level (one directory above the repo). Never place a bugfix under `../features/bugfixes/` or a code-review under `../features/code-reviews/`. If you find yourself building a path like `../features/<other-category>/...`, stop and re-derive from `../<category>/` directly.

4. **Fetch first — always branch off latest `origin/master`.**

   ```sh
   git fetch origin master
   ```

   The primary checkout is routinely stale or sitting on an unrelated branch, so a worktree created without fetching starts life hundreds of commits behind and inherits avoidable rebase conflicts later. Never branch from whatever the primary repo's `HEAD` happens to point at.

5. **Run the add command.**

   - If `services == true` (**cocam**): `cocam worktree add` can't write to nested paths, so create flat first and then move into `../<category>/`. The move is safe because `WorktreeManager` (`scripts/cocam/lib/worktree_manager.rb`) derives `COMPOSE_PROJECT_NAME` and port allocations from the directory **basename**, not the full path — moving preserves both.

     `cocam worktree add` takes no start-point argument — it branches from the current `HEAD` — so **verify the base immediately after creating** and correct it if it drifted:

     ```sh
     # after creating, from inside the new worktree
     git rev-list --count HEAD..origin/master   # must be 0
     ```

     If it is behind and the worktree has no commits of its own, reset it onto fresh master (`git reset --hard origin/master`); this is a clean reset, not a conflict-prone replay. Then `bundle install`, `dip rails db:migrate`, and `yarn install` to catch up dependency and schema drift, in that order.

     ```sh
     # 1. Create at the flat path (cocam rejects `/` and `.` in identifiers)
     cocam worktree add <TICKET>-<name>

     # 2. Before moving, stop any docker containers cocam started.
     #    As of this writing, `cocam worktree add` only copies volumes and does
     #    NOT auto-start services (it prints "Next steps: cocam up"). Still verify:
     #      docker ps --filter "name=^<project_name>-" --format '{{.Names}}'
     #    where <project_name> is the basename lowercased with non-alphanumerics → `_`
     #    (e.g. `CHE-71-web-comment-deeplink` → `che_71_web_comment_deeplink`).
     #    If anything is running:
     #      (cd ../<TICKET>-<name> && docker compose down)

     # 3. Move into the category subdir (basename preserved → cocam state stable)
     mkdir -p ../<category>
     git worktree move ../<TICKET>-<name> ../<category>/<TICKET>-<name>
     ```

     Bring services up later from the new location with `cd ../<category>/<TICKET>-<name> && cocam up` when ready to work.

   - If `services == false` (**plain git**): direct create at the target path. Pass `origin/master` as an explicit start point so the branch cannot inherit a stale base.

     ```sh
     mkdir -p ../<category>
     git worktree add -b <TICKET>-<name> ../<category>/<TICKET>-<name> origin/master
     ```

6. **Copy local skill directories into the worktree.** Skills under `.claude/skills/` that git doesn't track (locally-authored, gitignored, or not yet committed) are invisible to a fresh worktree — copy them over so the worktree has the same skills as the primary repo.

   First check what `.claude/skills` actually is in the primary repo:

   - **Symlink** (e.g. companycam-mobile, where `.claude/skills -> ../.agents/skills`) — if the symlink and its target are tracked, git already carries them into the worktree. **Skip this step.**
   - **Real directory** (e.g. the api repo) — copy the untracked ones:

     ```sh
     # from the primary repo
     WT=../<category>/<TICKET>-<name>
     mkdir -p "$WT/.claude/skills"
     for d in .claude/skills/*/; do
       # skip tracked skills — the worktree checkout already has them, and its
       # branch version may legitimately differ from the primary's
       [ -n "$(git ls-files -- "$d")" ] && continue
       # Strip the trailing slash on the source and name the destination explicitly.
       # `cp -R "$d" "$WT/.claude/skills/"` with a trailing slash on $d copies the
       # directory's *contents* flat into the destination on macOS/BSD cp (no
       # wrapping subdirectory), scattering loose SKILL.md/references/ files
       # directly under .claude/skills/ and silently clobbering same-named files
       # from other skills copied in the same loop.
       name=$(basename "$d")
       cp -R "${d%/}" "$WT/.claude/skills/$name"
     done
     ```

   Report which skill directories were copied. If none were untracked, say so rather than staying silent.

7. **Install and configure lefthook.** Both repos ship `scripts/setup-lefthook.sh` (normally run via `yarn postinstall`), and it is already worktree-aware. Run it directly from inside the new worktree rather than waiting on a full `yarn install`:

   ```sh
   cd ../<category>/<TICKET>-<name>
   [ -f scripts/setup-lefthook.sh ] && bash scripts/setup-lefthook.sh
   ```

   What it does, and why each half matters:

   - **Symlinks `lefthook-local.yml`** from the main worktree (bootstrapping it there from `lefthook-local.example.yml` first if absent). **This is the part that actually matters.** Every command in the tracked `lefthook.yml` is `skip: true`; only the gitignored `lefthook-local.yml` un-skips them. Being gitignored, it never travels with the checkout — so a worktree without it silently runs **zero** hooks even though the developer enabled them in the primary. A symlink (not a copy) keeps the two in sync when either side is edited later.
   - **Runs `yarn lefthook install --reset-hooks-path`**, which often fails in a fresh worktree — `.yarn/cache` isn't populated yet, and a plain-git worktree has no `.env`, so `.yarnrc.yml`'s `injectEnvironmentFiles` leaves `TIPTAP_PRO_TOKEN` unset and *every* `yarn` command errors out. **That failure is harmless — don't chase it.** The script guards the call and still exits 0, and the hooks are already in place regardless: worktrees share `$GIT_COMMON_DIR/hooks` (`git rev-parse --git-path hooks` resolves to the primary's `.git/hooks`), and lefthook's generated hook locates both its binary and its config through `git rev-parse --show-toplevel`, which resolves to the *worktree*. The primary's installed hooks therefore run per-worktree with no re-install.

   Verify — this must print a symlink pointing into the primary repo:

   ```sh
   ls -l lefthook-local.yml
   ```

   Never `cp` the primary's `lefthook-local.yml` in place of the symlink: a copy diverges silently, and a hook the developer enables in the primary later will never reach the worktree.

8. **Open a herdr tab in the `cycle` workspace.** Resolve the new worktree's absolute path from `git worktree list --porcelain`; use that path as `<worktree-absolute-path>` below. Earlier steps may have changed the shell's directory, so do not derive it by appending `../<category>/...` to the current `pwd`.

   Run `herdr workspace list` in the target running session and find the workspace whose label is exactly `cycle`. Read its ID from the response; do not hardcode an ID or use whichever workspace is focused. If multiple workspaces have that exact label, ask which one to use.

   **If `cycle` exists**, create the worktree tab there:

   ```sh
   herdr tab create --workspace <cycle-workspace-id> --cwd "<worktree-absolute-path>" --label "<ticket-lower>" --focus
   ```

   **If `cycle` does not exist**, create it rooted in the new worktree:

   ```sh
   herdr workspace create --cwd "<worktree-absolute-path>" --label "cycle" --focus
   ```

   Workspace creation also creates an initial tab. Reuse that tab: read its ID from `.result.tab.tab_id` in the creation response and rename it, rather than creating an extra tab:

   ```sh
   herdr tab rename <created-tab-id> "<ticket-lower>"
   ```

   Label the tab after the ticket identifier, lowercased (e.g. `CHE-27` → `che-27`, `CON-433` → `con-433`) — not the full `<TICKET>-<name>` path. Keep the workspace label `cycle`. This uses the running herdr session; it does not create a separate named session per worktree.

   Verify the resulting tab with `herdr tab list --workspace <cycle-workspace-id>`. If herdr is unavailable, its server is not running, or a command fails, report that the worktree was created but the herdr tab setup is incomplete. A failed workspace lookup is not evidence that `cycle` is absent. Inspect live state before retrying a partially completed creation to avoid duplicate workspaces or tabs.

## Remove

**Inputs:**
- `name` (string, required) — name (or path) of the worktree to remove. May include the ticket prefix or not; treat the basename as the worktree directory name.

**Steps:**

0. **Resolve the worktree path.** If `name` is bare (no `/`), run `git worktree list` and match it against the basenames of each worktree path. Match permissively — `foo`, `CHE-27-foo`, and `features/CHE-27-foo` should all resolve to a worktree directory ending in `CHE-27-foo`. If multiple worktrees match, prompt the user to pick one. If none match, fall back to checking `../features/`, `../bugfixes/`, and `../code-reviews/`. If `name` is a path, use it as-is.

1. **Preserve uncommitted `docs/` entries.** Before destroying the worktree, copy any uncommitted files/dirs under the worktree's top-level `docs/` back to the primary repo's `docs/`:

   ```sh
   # from inside the worktree
   git status --porcelain -- docs/
   ```

   For each modified or untracked path reported, copy it to the matching path in the primary repo with `cp -r`, creating parent directories as needed. Only copy paths that are uncommitted in the worktree — do not touch clean files.

2. **Preserve skill directories from the worktree.** Skills authored or edited inside the worktree but never committed would be destroyed with it. Copy them back to the **primary repo**'s `.claude/skills/` — resolve the primary with `git worktree list` (first entry is the primary working tree). For the api repo that resolves to `~/code/companycam/api/.claude/skills/`.

   Skip this step if the worktree's `.claude/skills` is a symlink (mobile) — the content is tracked and lives in the primary already.

   ```sh
   # from inside the worktree
   PRIMARY=$(git worktree list --porcelain | head -1 | cut -d' ' -f2)
   for d in .claude/skills/*/; do
     name=$(basename "$d")
     # tracked skills belong to the branch — don't push them into the primary
     [ -n "$(git ls-files -- "$d")" ] && continue
     if [ -d "$PRIMARY/.claude/skills/$name" ]; then
       diff -rq "$d" "$PRIMARY/.claude/skills/$name"   # differs? ask the user
     else
       # ${d%/} + explicit destination name — a trailing slash on $d makes
       # BSD cp copy contents flat into the destination instead of the
       # directory itself (see the Add step 6 note above).
       cp -R "${d%/}" "$PRIMARY/.claude/skills/$name"
     fi
   done
   ```

   - **Not present in the primary** → copy it over.
   - **Present and identical** → nothing to do.
   - **Present but different** → do **not** overwrite silently. Show the user the diff and ask whether to overwrite, keep the primary's version, or skip.

   Report what was copied, skipped, and left for the user to decide.

3. **Detect the worktree variant.** Read the worktree's `.env`:
   - Contains a `COCAM_*_PORT` key (e.g. `COCAM_RAILS_PORT`) → cocam worktree
   - Otherwise → plain git worktree

4. **Run the matching remove command.** Confirm with the user before running — destructive.

   - cocam worktree:

     ```sh
     cocam worktree remove <name>
     ```

     Also tears down docker services. **Gotcha**: `cocam worktree remove` resolves `<name>` to `../<identifier-with-slashes-collapsed-to-dashes>`, so once the worktree has been moved into `../<category>/` (per Add step 5), passing the bare identifier, the `category/identifier` path, or `-f` all fail with "Worktree not found" — it's looking for a flat `../<category>-<TICKET>-<name>` path that never existed. Run it from inside the worktree directory instead (`cd` in first, then `cocam worktree remove <basename> -y`); that still correctly tears down the Docker volumes/services. If the git-level removal itself then fails (e.g. "contains modified or untracked files" from artifacts like the skill-copy step), finish with plain git directly — the Docker side is already handled by that point:

     ```sh
     git worktree remove -f ../<category>/<TICKET>-<name>
     ```

   - plain git worktree:

     ```sh
     git worktree remove <name>
     ```

5. **Delete the local branch.** `git worktree remove` (and `cocam worktree remove`) only removes the working tree — the local branch survives and is easy to forget. Delete it as part of teardown, not as an afterthought:

   ```sh
   git branch -d <TICKET>-<name>
   ```

   Use `-d` (not `-D`) so an unmerged branch fails loudly rather than silently losing commits — if it refuses, surface that to the user instead of forcing.

## Notes

- If `git status` in the worktree shows uncommitted changes outside `docs/`, surface them to the user before proceeding with remove — don't silently destroy work.
- The copy-back is one-directional (worktree → primary). It does not commit or stage anything in the primary repo; the user can review and stage manually.
- Skill copying only ever moves **untracked** skill directories. Tracked skills already travel with the git checkout, and a worktree's branch may intentionally carry a different version — copying those in either direction would clobber real work.
- A worktree's `lefthook-local.yml` is a symlink to the primary's file, so editing it from inside a worktree changes the shared config for **every** worktree. That is usually what you want; just don't treat it as worktree-local. It also means remove is safe — deleting the worktree unlinks the symlink and leaves the primary's file intact — unless the worktree's copy is a real file rather than a symlink, in which case it is gitignored local config that removal will destroy.
- On add, if the user has already supplied a name that looks like it has a ticket prefix (e.g. `CHE-27-foo`), still prompt before adding a second prefix — confirm whether to skip ticket creation and use the existing reference.
