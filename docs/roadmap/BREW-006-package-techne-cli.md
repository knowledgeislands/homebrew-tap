---
id: BREW-006
title: Package Techne CLI
theme: formula-coverage
horizon: triage
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-09-20T08:01:34Z
updated_at: 2026-09-20T08:01:34Z
---

## Goal

Package an immutable released Techne CLI in Homebrew Tap and verify the formula installs the correct platform artifact with its published checksum.

## Context

`tools-techne` now has an accepted local installer, diagnostic provenance, and release-packaging workflow, but no source release has been published. The tap must not add a placeholder or floating formula; it needs an observed immutable release archive and checksum from `tools-techne`.

## Boundary

Do not publish or tag `tools-techne` from this repository, invent checksums, point a formula at a branch or mutable asset, or make the tap own Techne runtime behaviour. This capture does not authorise formula publication or a tap release.

## Discussion

### Repository boundary

`tools-techne` owns source release creation and artifact integrity. Homebrew Tap owns formula syntax, platform selection, checksum binding, installation tests, and tap documentation once those immutable inputs exist.

### Adoption condition

Shape this item only after `tools-techne` publishes the reviewed semantic-version release and all supported archive checksums are observable. Verification should include formula audit, install, `techne --version`, and offline `techne diag --json` evidence.
