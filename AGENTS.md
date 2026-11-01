# Agent Instructions

This project uses **dotdiw** (beads) for issue tracking. Run `dotdiw prime` for full workflow context.

> **Architecture in one line:** Issues live in a local Dolt database
> (`.beads/dolt/`); cross-machine sync uses `dotdiw dolt push/pull` (a
> git-compatible protocol), stored under `refs/dolt/data` on your git
> remote — separate from `refs/heads/*` where your code lives.
> `.beads/issues.jsonl` is a passive export, not the wire protocol.
>
> See [sync-concepts](https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md)
> for the one-screen overview and anti-patterns (don't treat JSONL as the
> source of truth; don't `dotdiw import` during normal operation; don't
> reach for third-party Dolt hosting before trying the default).

## Quick Reference

```bash
dotdiw ready              # Find available work
dotdiw show <id>          # View issue details
dotdiw update <id> --claim  # Claim work atomically
dotdiw close <id>         # Complete work
dotdiw dolt push          # Push beads data to remote
```

## Non-Interactive Shell Commands

**ALWAYS use non-interactive flags** with file operations to avoid hanging on confirmation prompts.

Shell commands like `cp`, `mv`, and `rm` may be aliased to include `-i` (interactive) mode on some systems, causing the agent to hang indefinitely waiting for y/n input.

**Use these forms instead:**
```bash
# Force overwrite without prompting
cp -f source dest           # NOT: cp source dest
mv -f source dest           # NOT: mv source dest
rm -f file                  # NOT: rm file

# For recursive operations
rm -rf directory            # NOT: rm -r directory
cp -rf source dest          # NOT: cp -r source dest
```

**Other commands that may prompt:**
- `scp` - use `-o BatchMode=yes` for non-interactive
- `ssh` - use `-o BatchMode=yes` to fail instead of prompting
- `apt-get` - use `-y` flag
- `brew` - use `HOMEBREW_NO_AUTO_UPDATE=1` env var

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:46cd31e7 -->
## Beads Issue Tracker

This project uses **dotdiw (beads)** for issue tracking. Run `dotdiw prime` to see full workflow context and commands.

### Quick Reference

```bash
dotdiw ready              # Find available work
dotdiw show <id>          # View issue details
dotdiw update <id> --claim  # Claim work
dotdiw close <id>         # Complete work
```

### Rules

- Use `dotdiw` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `dotdiw prime` for detailed command reference and session close protocol
- Use `dotdiw remember` for persistent knowledge — do NOT use MEMORY.md files

**Architecture in one line:** issues live in a local Dolt DB; sync uses `refs/dolt/data` on your git remote; `.beads/issues.jsonl` is a passive export. See https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md for details and anti-patterns.

## Agent Context Profiles

The managed Beads block is task-tracking guidance, not permission to override repository, user, or orchestrator instructions.

- **Conservative (default)**: Use `dotdiw` for task tracking. Do not run git commits, git pushes, or Dolt remote sync unless explicitly asked. Committing a `*.formula.toml` file is the one exception: the project asks for it under "How work starts" below, so it is already explicitly asked. Commit that file and leave your other changes alone. At handoff, report changed files, validation, and suggested next commands.
- **Minimal**: Keep tool instruction files as pointers to `dotdiw prime`; use the same conservative git policy unless active instructions say otherwise.
- **Team-maintainer**: Only when the repository explicitly opts in, agents may close beads, run quality gates, commit, and push as part of session close. A current "do not commit" or "do not push" instruction still wins.

## Session Completion

This protocol applies when ending a Beads implementation workflow. It is subordinate to explicit user, repository, and orchestrator instructions.

1. **File issues for remaining work** - Create beads for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **Handle git/sync by active profile**:
   ```bash
   # Conservative/minimal/default: report status and proposed commands; wait for approval.
   git status

   # Team-maintainer opt-in only, unless current instructions forbid it:
   git pull --rebase
   dotdiw dolt push
   git push
   git status
   ```
5. **Hand off** - Summarize changes, validation, issue status, and any blocked sync/commit/push step

**Critical rules:**
- Explicit user or orchestrator instructions override this Beads block.
- Do not commit or push without clear authority from the active profile or the current user request.
- If a required sync or push is blocked, stop and report the exact command and error.
<!-- END BEADS INTEGRATION -->

<!-- BEGIN BEADS CODEX SETUP: generated by dotdiw setup codex -->
## Beads Issue Tracker

Use Beads (`dotdiw`) for durable task tracking in repositories that include it. Use the `beads` skill at `.agents/skills/beads/SKILL.md` (project install) or `~/.agents/skills/beads/SKILL.md` (global install) for Beads workflow guidance, then use the `dotdiw` CLI for issue operations.

### Quick Reference

```bash
dotdiw ready                # Find available work
dotdiw show <id>            # View issue details
dotdiw update <id> --claim  # Claim work
dotdiw close <id>           # Complete work
dotdiw prime                # Refresh Beads context
```

### Rules

- Use `dotdiw` for all task tracking; do not create markdown TODO lists.
- Run `dotdiw prime` when Beads context is missing or stale. Codex 0.129.0+ can load Beads context automatically through native hooks; use `/hooks` to inspect or toggle them.
- Keep persistent project memory in Beads via `dotdiw remember`; do not create ad hoc memory files.

**Architecture in one line:** issues live in a local Dolt DB; sync uses `refs/dolt/data` on your git remote; `.beads/issues.jsonl` is a passive export. See https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md for details and anti-patterns.
<!-- END BEADS CODEX SETUP -->

<!-- dotdiw: how work starts -->
## How work starts in this project

Start every task and subtask with:

    dotdiw create "<what you are about to do>"

That is the convention, and it is also what lets the right procedure find you.
On `create`, the procedures this project holds are matched against your title
and the ones that apply are printed. Start by cutting a branch or editing a
file instead and nothing surfaces -- the discipline was skipped, not the
mechanism broken.

A procedure you repeat belongs in a formula, not a runbook: a TOML file named
`<something>.formula.toml`, kept next to whatever it is about, and committed.
Prose cannot be matched against a title or instantiated as steps; a formula is
both. Leave it where it belongs in the tree -- it does not need moving or
linking anywhere.

Write one the moment you notice you are repeating yourself, or that you just
did by hand what you will do again. `formula new` writes the file for you; you
fill in the description and the steps.

Then commit it. A formula you have not committed is one only you hold: it does
not appear in `formula list`, nothing matches it against a title, and `check`
says so. Committing it is the last step of writing it, not a separate decision
-- and this is the project asking you to, so it is not the kind of commit a
conservative git policy is about. Commit the formula file; leave the rest of
your changes as they are.

    dotdiw formula new "<what the procedure is for>"
    dotdiw formula new "..." --from <id>   steps from work already done
    dotdiw formula list     the procedures this project holds
    dotdiw mol pour <id>    instantiate one as tracked, ordered steps
    dotdiw check            whether every formula here can actually be found
    dotdiw learn            all of it, in full
<!-- /dotdiw -->
