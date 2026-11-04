# homebrew-tap

A Homebrew tap. Every tool in it installs as
`brew install adimpression/tap/<name>` and upgrades with `brew upgrade <name>`.
Each tool has a section below: its install line, then a notice per version,
newest first.

## dotdiw

    brew install adimpression/tap/dotdiw

Already installed from this tap: `brew upgrade dotdiw`.

## dotdiw 0.6.0

You can now choose which tracker dotdiw works on, and nothing changes unless
you do. A checkout already adopted stays on its tracker. dotdiw records that
in `.git/config` and says so once. After that, twenty commands print the same
bytes as 0.5.0, so nothing is asked of you on upgrade. `--version` now names
the tracker.

A checkout adopted from now on uses `local`: one sqlite file under
`~/.dotdiw/<key>/`, with nothing to install and nothing running. Besides
dotdiw's own commands it answers `list`, `ready`, `show`, `close`, `update`
and `dep add`, and refuses anything else by name. `dotdiw init --tracker beads`
adopts on beads instead.

`dotdiw tracker list` names the trackers. `dotdiw tracker use <name>` switches
a checkout and leaves its work where it is. `dotdiw tracker migrate <from> <to>`
moves the work, with its statuses, needs and close reasons but not its
descriptions, and never writes to the source.

This formula still installs beads. 0.7.0 makes it optional.

## dotdiw 0.5.0

Every operation is now invoked through one door generated from dotdiw's
operation IDL, and no body writes to the terminal; the command line shows
each response as its operation returns. What dotdiw prints, writes and runs
is unchanged, seventeen commands byte for byte against 0.4.1, so nothing is
asked of you on upgrade.

## dotdiw 0.4.1

What dotdiw prints names the tracker and never the tool underneath it: the
line when the tracker is missing is the install command above; the metrics
notice names the tracker and the file it changed; `--version` reports the
tracker's version as a number. What dotdiw does, writes and runs is
unchanged, so nothing is asked of you on upgrade.

## dotdiw 0.4.0

The tracker's state leaves the repository. `dotdiw init` writes one line into
the checkout's own `.git/config`, `dotdiw.workspace`, and runs bd under
`~/.dotdiw/<key>/`; every dotdiw command tells bd where through `BEADS_DIR`.
The repository holds only the formulas and the declaration in `CLAUDE.md` and
`AGENTS.md`. The key survives a move and worktrees share it; a fresh clone has
none, so it runs `dotdiw init` once, and `create` says so until it has. A plain
`bd` typed in the repository finds no tracker; everything goes through dotdiw.

If you adopted a repository with an earlier version: close your tasks before
upgrading, because the task history is not carried over. After
`brew upgrade dotdiw`, the first dotdiw command adopts the checkout under your
home with the same prefix, says so once, and names the one command that removes
the unused `.beads/` from the tree:

    git rm -r -q .beads && git commit -m "Remove the tracker's files from the repository" && rm -rf .beads .beads.gate.lock

where it was committed, and `rm -rf .beads .beads.gate.lock` where it was not.
dotdiw runs neither, and never edits the old copy.

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
