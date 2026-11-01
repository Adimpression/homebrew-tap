# homebrew-tap

**The `dotdiw` formula has been withdrawn. There is nothing to install here.**

`dotdiw init` passed straight through to `bd init`, which sets `core.hooksPath`
to `<repo>/.beads/hooks`. That replaces a repository's own `.git/hooks`
wholesale: every hook the project relied on -- lint, tests, secret scanning,
commit-message checks -- stops running without a word, and five beads hooks run
instead, one of which rewrites commit messages. It also configures a Dolt remote
aimed at the repository's git remote, so the issue database is pushed into the
repository, and it inherits beads' telemetry, which ships enabled.

None of that was disclosed, and the project's README claimed the opposite.

## If you ran `dotdiw init`

One command per affected repository restores your own hooks:

    git config --unset core.hooksPath

Then check for the rest:

    grep -n 'remote:' .beads/config.yaml          # a Dolt remote, if present
    git log --oneline --all -- .beads | head      # a database pushed in
    git log --format='%h %s%n%b' -50 | grep -niE 'beads|dotdiw'

Telemetry is global rather than per-repository. In `~/.config/bd/config.yaml`:

    metrics:
        disabled: true

Nothing was deleted and no history was rewritten by any of this. The hooks
override and the Dolt remote are each a single configuration entry, and
removing them puts the repository back as it was.
