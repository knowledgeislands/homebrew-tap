---
id: BREW-001
title: Repin git-almanac formula
theme: formula-coverage
horizon: waiting-for
status: draft
blocks: []
blocked_by: []
baseline_ref: null
---

## Goal

`brew install knowledgeislands/tap/git-almanac` installs the version of Git Almanac that its own repository considers current, the same way the tap tracks `ki` and `mgit`.

## Context

The formula now exists and is complete: `Formula/git-almanac.rb` installs the released `git-almanac` executable and its `git-almanac.1` manual, depends on `node`, and tests the installed binary. It is pinned to v1.0.1, whose release asset checksum was verified against the published `SHA256SUMS`.

That pin is expected to be short-lived. Git Almanac's versioning is being revised in its own repository and an interim release is planned, so the tap will need to follow it once that lands.

Everything except the pin is settled, which is the point of landing the formula now: the remaining change is two lines.

## Boundary

This item repoints an existing formula at a newer release. It does not cut or influence the upstream release, restructure the formula, change what Git Almanac ships, or add bottle or `head` support.

## Shaping

When the interim release is published, update `url` and `sha256` in `Formula/git-almanac.rb`, and nothing else unless the release changes shape.

The checksum comes from the release's own `SHA256SUMS`, cross-checked locally with `curl -fsSL <tarball> | shasum -a 256`. `version` is inferred from the URL, so the `test do` assertion on `--version` stays honest without editing.

Verify with `brew style`, `brew audit --strict --online git-almanac`, then `brew install --build-from-source` and `brew test` against the tap. Note that `brew audit` and `brew install` resolve a formula by name through the tapped clone under `$(brew --repository)/Library/Taps/`, not from a working copy, so they need the change pushed or the tap pointed at this checkout.

Promotion condition: the interim release is published with an archive and checksum.

## Discussion

### Why the mechanics landed before the version settled

The release-shape questions that actually affect the formula are already answered. Git Almanac publishes a single platform-independent release asset containing a bundled Node script and its manual, so the formula needs one `url`/`sha256` pair rather than the `on_arm`/`on_intel` blocks `ki` requires, and `bin.install` plus `man1.install` rather than a build step. A later version cannot change that without changing how the tool ships.

### Runtime dependency

The released executable is a bundled ESM script with a `#!/usr/bin/env node` shebang and no runtime dependencies of its own, and the package declares `engines.node >= 22`. `depends_on "node"` is therefore the whole dependency story — unlike `ki`, which ships a self-contained compiled binary, and `mgit`, which is a shell script.
