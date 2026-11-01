# homebrew-tap

**The `dotdiw` formula is withdrawn pending a corrected release. There is
nothing to install here yet.**

## Correction

An earlier version of this notice said that `dotdiw init` stopped a
repository's own git hooks from running. **That was wrong, and it was wrong
about someone else's project.** It was published without being tested. The
test that disproves it takes a minute to run.

What actually happens: `bd init` sets `core.hooksPath` to `<repo>/.beads/hooks`
and **copies the hooks already in `.git/hooks` into that directory**, appending
its own block below them. Hooks that existed when the repository was adopted
keep running. No lint, test or secret-scanning hook was disabled by this.

## What is actually wrong

`dotdiw init` passed straight through to `bd init` and inherited four things
without disclosing any of them:

1. **Hooks added after adoption were skipped.** git reads one hook directory,
   and from adoption onward that is bd's snapshot. A hook added to
   `.git/hooks` next week was invisible to git until the override was removed.
   This is real, and narrower than the claim it replaces.
2. **`core.hooksPath` was an absolute path**, so it was also wrong in any other
   checkout of the same repository.
3. **A Dolt remote aimed at the repository's git remote**, which pushes the
   issue database into the repository, where it keeps its full history and
   never shrinks.
4. **Telemetry**, which beads ships enabled.

`init` also edited files after bd had committed them, leaving the working tree
dirty and the committed copies stale.

## If you ran `dotdiw init`

One command removes the hook override and makes `.git/hooks` authoritative
again:

    git config --unset core.hooksPath

The Dolt remote lives in two places, `.beads/config.yaml` under a `sync:` key
and `remotes` in `.beads/embeddeddolt/*/.dolt/repo_state.json`. Telemetry is
global rather than per-repository, in `~/.config/bd/config.yaml`.

Nothing was deleted and no history was rewritten by any of this.

The corrected release repairs all of it on any invocation and prints what it
undid, so once it is published an upgrade is enough.
