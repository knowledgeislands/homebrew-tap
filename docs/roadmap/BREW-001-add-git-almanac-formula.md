---
id: BREW-001
title: Add git-almanac formula
theme: formula-coverage
horizon: waiting-for
status: draft
blocks: []
blocked_by: []
waiting_on_trades: [TRD-96f0b04f]
baseline_ref: null
---

## Goal

Someone can install Git Almanac with `brew install knowledgeislands/tap/git-almanac`, the same way they already install `ki` and `mgit`, and can upgrade it through Homebrew when a later version ships.

## Context

The tap currently packages two of the three Knowledge Islands command-line tools. Git Almanac is the third and is absent, so its only install route is its own installer script.

`knowledgeislands/tools-git-almanac` asked for this through [TRD-96f0b04f](../../+/_TRADES/knowledgeislands/tools-git-almanac/TRD-96f0b04f.md), an adopted inbound work trade whose submission is explicitly conditional: add the formula _after_ an immutable v1.0.0 is published, using `git-almanac-v1.0.0.tar.gz` and its published checksum.

That release does not exist yet. Separate work in that repository is preparing it: `package.json` is at `1.0.0` and the changelog heads `## [1.0.0] — in progress`, but the repository still has no tags and no published releases. A formula cannot be written before one exists, because it must point at a versioned release tarball and its `sha256`, never a branch.

The tool itself is already shaped for packaging: it ships `bin/git-almanac` and `man/git-almanac.1`, matching what `Formula/mgit.rb` installs.

## Boundary

This item adds one formula to this tap and its README row. It does not cut, verify, or influence the upstream v1.0.0 release, change how Git Almanac builds or what it ships, alter the tap's other formulae, or introduce bottle or `head` support.

## Shaping

The approach is the established one, so the item is mostly a wait rather than a design.

Copy the shape of an existing formula and adjust it: `class GitAlmanac < Formula` with a `desc` under 80 characters that does not open with an article, the `homepage`, the released tarball `url`, its `sha256` from `curl -fsSL <tarball> | shasum -a 256`, the `license`, an `install` method placing the binary and `man/git-almanac.1`, and a `test do` block asserting on the installed binary's real output. Add the row to the README `## Formulae` table. Validate with `brew audit --strict --online`, `brew style`, `brew install --build-from-source`, and `brew test`.

One decision is genuinely open and belongs to the release, not to this item: whether Git Almanac publishes a source tarball built at install time, as `mgit` does, or per-platform release archives, as `ki` does. That choice determines whether the formula is a single `url`/`sha256` pair or `on_arm`/`on_intel` blocks, and it can be read off the published release rather than guessed now.

Promotion condition: an immutable v1.0.0 tag with a published archive and checksum is observable in `knowledgeislands/tools-git-almanac`.

## Discussion

### Why this waits rather than parks

The blocking condition is external, specific, and expected to clear on its own, which is what `waiting-for` is for. `waiting_on_trades` records the trade as the observed cross-repository condition rather than a local dependency, so the trade identity stays out of `blocked_by`.

### Trade disposition

The trade is `adopted`, with this item named as `adopted_as`. Adoption records that the request now informs separately governed local work; it does not assert the formula exists. The sender chose `observation: completion`, which adoption deliberately does not satisfy, so the outbound record stays waiting until the formula actually lands here.
