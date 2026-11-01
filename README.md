# homebrew-tap

    brew install adimpression/tap/dotdiw

Already installed from this tap: `brew upgrade dotdiw`.

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
