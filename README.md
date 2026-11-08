# homebrew-tap

A Homebrew tap. Every tool in it installs as
`brew install adimpression/tap/<name>` and upgrades with `brew upgrade <name>`.
Each tool has a section below: its install line, then a notice per version,
newest first.

## dotdiw

    brew install adimpression/tap/dotdiw

Already installed from this tap: `brew upgrade dotdiw`.

## dotdiw 1.1.0

dotdiw works as 1.0.0 does: every command, every tracker and every file it
writes are the same. What changed is how dotdiw holds itself to its promise.
Each of its operations now declares, in its POA model, what it takes, what it
returns, what it calls and the git and beads commands it runs, and the
operation IDL is built from that model alone.

The formula management abstraction is planned and recorded in dotdiw's
promise: providers registered under a name, keeping formulas on a file system
or behind an API endpoint, each formula carrying its provider's name as a
suffix. Its implementation is a later release.

dotdiw-tracker-jira stays at 1.0.0 and works with 1.1.0.

## dotdiw 1.0.0

`dotdiw formula pour <id>` creates a formula's steps as tracked items, and
`create`, `formula list` and `learn` point to it. `mol pour` still works and
prints the same. The instructions dotdiw writes into CLAUDE.md and AGENTS.md
keep 0.7.0's text, so a team on mixed versions writes the same files.

A formula can name the means to prove its run in a list called `verify-using`:
a command after `run:`, a file in a repository as a `git+https://` or
`git+ssh://` URL with its path after `#`, or a link. dotdiw shows them after a
pour and keeps them with the root, and `dotdiw check` names any value it cannot
read. Proving the run is the act of whoever ran it.

An item's kind is root or task: a pour makes the root, and every other item is
a task. `create -t` and `--type` no longer set a kind, and under beads a type of
molecule is refused. A local store made before 1.0.0 reads its molecule rows as
roots.

Trackers implement interface 2, and dotdiw refuses a tracker that declares 1 in
one line that names it. If you use Jira, upgrade both packages together:
`brew upgrade dotdiw dotdiw-tracker-jira`. A tracker of your own needs a new
version that declares 2, and `trackers/README.md` in dotdiw's repository says
what it answers.

A tracker can name the account it writes under. Jira confirms it from the API
token, and `init` and `tracker use` name that account. `update -a me` assigns an
item to it, and `show` prints the assignee under local and Jira. `tracker
migrate` carries descriptions and the means to prove a run, and says how many
items had an assignee, since assignees stay behind.

## dotdiw 0.7.0

This formula no longer installs beads, as the 0.6.0 notice said it would. A
checkout on `local` needs nothing else.

If you keep a checkout on beads, run `brew install beads` once. Homebrew answers
that it is already installed, and from then on keeps it. Without that, `brew
upgrade dotdiw` leaves beads installed, but if it came only as dotdiw's
dependency, Homebrew can remove it later, at a periodic cleanup or on `brew
autoremove`. If it goes, that checkout's commands say `dotdiw: beads is not
installed. Run: brew install beads` and exit 127, and the work is there once
beads is back. Under beads, twenty commands print the same bytes as 0.6.0, apart
from the tracker paragraph of `dotdiw learn`.

A tracker can now ship as a package named `dotdiw-tracker-<name>`, which installs
one file under `share/dotdiw/trackers/`. `dotdiw tracker new <name>` writes the
file to start from, and `dotdiw tracker check ./<name>.py` checks it without
installing it. Compatible means ten of ten. `trackers/README.md` in dotdiw's
repository gives the steps. A tracker's code runs with your rights whenever
dotdiw loads it, and `dotdiw tracker list` loads every one it finds.
`dotdiw-tracker-jira`, at the end of this file, is the first.

Fixed since 0.6.0: `tracker check` could write into the checkout it ran from. A
module that called `sys.exit()` ended the command with no output and exit 0.
`init` went on declaring the conventions after a tracker failed to open. `tracker
use` reported a choice it could not write. Under `local`, a failed `create`
printed nothing, `update -p` with a word gave a traceback, and a second open took
a new prefix.

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

## dotdiw-tracker-jira

    brew install adimpression/tap/dotdiw adimpression/tap/dotdiw-tracker-jira

A dotdiw tracker that keeps a checkout's work in a Jira Cloud project. Name both
packages: Homebrew loads a dependency from a tap only if that formula is trusted,
and naming a formula in `brew install` trusts it.

It reads `JIRA_SITE`, `JIRA_EMAIL` and `JIRA_API_TOKEN` from the environment or
from `~/.dotdiw/trackers/jira.json`. `dotdiw init --tracker jira --prefix PROJ`
then sends a checkout's work to project PROJ.

It passes ten of ten against a stub of Jira's API in dotdiw's tests. It has not
yet run against a live Jira site.

Jira is a registered trademark of Atlassian Pty Ltd.
