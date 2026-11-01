# homebrew-tap

    brew install adimpression/tap/dotdiw

Already installed from this tap: `brew upgrade dotdiw`.

## dotdiw 0.3.0

`dotdiw init` now runs bd in its stealth mode, `bd init --stealth --skip-hooks`.
bd commits nothing, writes nothing for agents, configures no remote, and keeps
`.beads/` local to the checkout through `.git/info/exclude`. What init leaves
behind is dotdiw's own declaration of where work starts, in `CLAUDE.md` and
`AGENTS.md`, named as yours to commit; the command it prints leaves the tree
clean. 0.2.0 and 0.2.1 used bd's default init and removed the sync remote
afterwards, which left `.beads/config.yaml` modified in every repository
adopted with a remote.

A repository adopted by 0.2.x keeps working. On `init`, `check`, `doctor` and
`lint` it is told the one command that keeps the tracker local from here on:

    git rm -r --cached .beads && git commit -m "Keep the tracker local to each checkout"

dotdiw never runs it. Nothing is deleted; the files stay on disk, excluded.
Clones that pull that commit run `dotdiw init` once, which was always needed
-- bd's database was never in git -- and is now said when `create` finds no
database. Outside a git repository, `init` refuses.

Also new: an opt-in local witness log (`DOTDIW_WITNESS=1`), never
transmitted, and the records that write dotdiw's promise down and bind the
program to it; see the repository's README.

## dotdiw 0.2.1

`dotdiw init` used to pass straight through to `bd init` and inherit, without
saying so, a `core.hooksPath` override aimed at `.beads/hooks` and a Dolt remote
aimed at the repository's git remote. Since 0.2.0 `init` declines both. In a
repository where an earlier version already left them, it undoes both on its
next invocation -- any command -- and prints what it undid. `init` also names
the files it edited after bd committed them, so they can be committed.

beads ships anonymous usage metrics on. 0.2.1 turns them off before it runs any
bd command, on every run, and says so the first time: `bd metrics off`, which
writes `metrics.disabled: true` to `~/.config/bd/config.yaml`. That is per
machine, not per repository, and it is the one thing dotdiw changes outside the
repository. Nothing already pushed into a repository's history is touched by
any version.

## Correction

An earlier version of this notice said that `dotdiw init` stopped a
repository's own git hooks from running. That was wrong, and it was wrong about
someone else's project; it was published without being tested. `bd init` copies
the hooks already in `.git/hooks` into its own directory, so hooks that existed
when the repository was adopted kept running. What was skipped was any hook
added afterwards, until the override was removed.
