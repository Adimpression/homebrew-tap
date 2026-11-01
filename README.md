# homebrew-tap

    brew install adimpression/tap/dotdiw

Already installed from this tap: `brew upgrade dotdiw`.

## dotdiw 0.2.0

`dotdiw init` used to pass straight through to `bd init` and inherit, without
saying so, a `core.hooksPath` override aimed at `.beads/hooks` and a Dolt remote
aimed at the repository's git remote. 0.2.0 declines both at `init`. In a
repository where an earlier version already left them, it undoes both on its
next invocation -- any command -- and prints what it undid. `init` also names
the files it edited after bd committed them, so they can be committed.

Not in 0.2.0: beads ships telemetry enabled, and 0.2.0 leaves that setting
alone. The next release turns it off; until then it is `metrics.disabled: true`
in `~/.config/bd/config.yaml`. Nothing already pushed into a repository's
history is touched by any version.

## Correction

An earlier version of this notice said that `dotdiw init` stopped a
repository's own git hooks from running. That was wrong, and it was wrong about
someone else's project; it was published without being tested. `bd init` copies
the hooks already in `.git/hooks` into its own directory, so hooks that existed
when the repository was adopted kept running. What was skipped was any hook
added afterwards, until the override was removed.
