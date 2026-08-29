---
id: BREW-001
title: Add git-almanac formula
theme: formula-coverage
horizon: now
status: done
blocks: []
blocked_by: []
baseline_ref: c9c6e70a47c5154df1d7b1b3299834304da9be51
---

## Goal

Someone can install Git Almanac with `brew install knowledgeislands/tap/git-almanac`, the same way they already install `ki` and `mgit`, and can upgrade it through Homebrew when a later version ships.

## Context

The tap packaged two of the three Knowledge Islands command-line tools. Git Almanac was the third and was absent, so its only install route was its own installer script.

Packaging waited on a published release, because a formula must point at a versioned release tarball and its `sha256`, never a branch. Git Almanac's versioning was revised while this item was open — earlier `v1.0.0` and `v1.0.1` tags were withdrawn — and it is now released as v0.1.0.

## Boundary

This item adds one formula to this tap and its README row. It does not cut, verify, or influence the upstream release, change how Git Almanac builds or what it ships, alter the tap's other formulae, or add bottle or `head` support.

## Current state

Delivered. `Formula/git-almanac.rb` is pinned to the v0.1.0 release asset and the README formulae table lists all three tools.

## Steps

- [x] Confirm a published release with a downloadable archive and checksum.
- [x] Verify the release asset's `sha256` against the published `SHA256SUMS`.
- [x] Write `Formula/git-almanac.rb` installing the executable and its manual.
- [x] Add the `git-almanac` row to the README `## Formulae` table.
- [x] Run `brew style` and the repository audit.

## Files touched

- `Formula/git-almanac.rb`
- `README.md`

## Verify

- `brew style Formula/git-almanac.rb` reports no offences.
- `ki repo audit --skill ki-repo-homebrew-tap --repo .` passes, including `TAP-6` formula discoverability.
- `shasum -a 256` of the downloaded release asset equals the value in the release's `SHA256SUMS` and the formula's `sha256`.

## Dependencies / blocks

No local blockers remain. The upstream release this formula pins is published and immutable.

## Documentation impact

### Decision Records

None. Adding a formula for an existing tool applies the established tap pattern and settles no new question.

### Specifications

None. The tap distributes tools; it defines no behaviour-level contract of its own.

### Guides

None beyond the README, which is the tap's user-facing guidance and carries the new row.

### Roadmap

None. A later version bump is routine maintenance under the workflow in `CLAUDE.md`, not follow-on work.

## Review

### Delivered

The approved boundary: one formula plus its README row, with the upstream release out of scope. Baseline `c9c6e70a47c5154df1d7b1b3299834304da9be51`; the formula landed in `7c7c310` and was repinned to the released v0.1.0 thereafter.

### Summary of changes

`Formula/git-almanac.rb` installs the released `git-almanac` executable and `git-almanac.1` manual, pinned to `git-almanac-v0.1.0.tar.gz` at `800260831367f40fce693bec3764f70d263cee97006ca406803f02db67e2e10c`, with `depends_on "node"` and a test asserting `--version` and `--help` output. The README formulae table gained the `git-almanac` row.

Two material decisions: a single `url`/`sha256` pair rather than `ki`'s `on_arm`/`on_intel` blocks, because the release ships one platform-independent asset; and `depends_on "node"`, because the released executable is a bundled ESM script with a `#!/usr/bin/env node` shebang and the package declares `engines.node >= 22`.

### Verification

`brew style Formula/git-almanac.rb` — 1 file inspected, no offences. `brew audit --strict --online knowledgeislands/tap/git-almanac` — exit 0, no findings. `brew install --build-from-source` installed `bin/git-almanac` and `share/man/man1/git-almanac.1` into the Cellar, and `brew test` ran both assertions against the installed binary and passed. The installed executable reports `git-almanac 0.1.0`. Release asset checksum verified against the published `SHA256SUMS`. `ki repo audit --repo .` reports no findings from this work.

### Outstanding concerns

None outstanding for the formula itself. The Homebrew gates were run against the tapped clone under `$(brew --repository)/Library/Taps/`, where the formula was staged as an untracked file because this change is not yet pushed; that staged copy will collide with the tracked file on the next `brew update` until it is removed. Separately, an existing `~/.local/bin/git-almanac` from the upstream installer shadows the Homebrew executable on this machine, which affects local invocation only, not the formula.

### Post-change review

The formula matches the shape of `mgit.rb` and `ki.rb`, which is what the tap standard asks for, and adds no construct the other two avoid.

### Mini recap

Git Almanac is now installable from the tap, completing coverage of all three Knowledge Islands command-line tools.

## Done

Accepted on 2026-08-29 on the user's explicit instruction to proceed once Git Almanac was tagged, with `brew style` and the repository audit clean and the release checksum verified. `brew audit --strict --online`, `brew install --build-from-source`, and `brew test` were subsequently run against the tapped clone and all passed.

## Discussion

### Version churn upstream

This item was opened when Git Almanac had no tags, then briefly tracked `v1.0.0` and `v1.0.1` before those were withdrawn in favour of v0.1.0. The formula pins the release that exists now; nothing in it depends on the version except `url` and `sha256`, so a future bump stays a two-line change.

### Runtime dependency

Unlike `ki`, which ships a self-contained compiled binary, and `mgit`, which is a shell script, Git Almanac ships a Node script. `depends_on "node"` is the whole dependency story — the bundle declares no runtime dependencies of its own.
