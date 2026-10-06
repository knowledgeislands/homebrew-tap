---
id: BREW-006
title: Package Techne CLI
theme: formula-coverage
horizon: now
status: awaiting-review
blocks: []
blocked_by: []
baseline_ref: a8816988e067dd87c2be75e971009ef6d7d92751
created_at: 2026-09-20T08:01:34Z
updated_at: 2026-10-06T01:12:00Z
---

## Goal

Package an immutable released Techne CLI in Homebrew Tap and verify the formula installs the correct platform artifact with its published checksum.

## Context

`tools-techne` now has an accepted local installer, diagnostic provenance, and release-packaging workflow, but no source release has been published. The tap must not add a placeholder or floating formula; it needs an observed immutable release archive and checksum from `tools-techne`.

## Boundary

Do not publish or tag `tools-techne` from this repository, invent checksums, point a formula at a branch or mutable asset, or make the tap own Techne runtime behaviour. This capture does not authorise formula publication or a tap release.

## Current state

The adoption condition is met and the formula exists. `tools-techne` v0.1.1 was first packaged (commit `2971210`, tap CI run `37069215625`). The release bot has since advanced the formula to v0.2.0 (PR #6, `6f34b15`): `tools-techne` v0.2.0 is published as an immutable, non-prerelease release with darwin-arm64, darwin-x64 and linux-x64 archives and a checksum file, and `Formula/techne.rb` pins those three archives and checksums.

## Steps

- [x] Take `baseline_ref`.
- [x] Confirm each `url` and `sha256` in `Formula/techne.rb` against the published v0.2.0 release assets (`gh release view v0.2.0 -R knowledgeislands/tools-techne --json assets,isImmutable` or equivalent and the published checksum file).
- [x] Run the local Homebrew gates and the `techne` smoke checks in Verify on this machine.
- [x] Record the evidence under `## Discussion` and move the record to Awaiting review. If any check fails, fix `Formula/techne.rb` within this boundary instead of recording delivery.

## Files touched

- This roadmap record.
- `Formula/techne.rb` only if a gate fails.

## Verify

```sh
brew style Formula/techne.rb
brew audit --strict --online knowledgeislands/tap/techne
brew reinstall --build-from-source knowledgeislands/tap/techne
brew test knowledgeislands/tap/techne
"$(brew --prefix)/bin/techne" --version
"$(brew --prefix)/bin/techne" diag --json
ruby test/tool_release_events_test.rb && ruby test/propose_tool_release_test.rb
ki repo audit --progress never
```

The brew-installed binary (not the local `~/.local/bin` link, which precedes Homebrew on PATH) prints `0.2.0`, and its `diag --json` runs offline and reports `"installation":"release"`, matching the formula's `test do`.

## Dependencies / blocks

Blocked by nothing. Website receipt of the Techne event is KI Website's concern (its own `techne` entry, PR #6), not this item's.

## Documentation impact

### Decision Records

None.

### Specifications

None.

### Guides

None; `README.md` already lists `techne`.

### Roadmap

Close with the recorded evidence.

## Review

### Delivered

Verification-only delivery within the boundary: nothing was published or tagged, and `Formula/techne.rb` needed no change. Baseline `a8816988e067dd87c2be75e971009ef6d7d92751`. The tap packages the immutable `tools-techne` v0.2.0 release with its published checksums, and the formula installs and passes its tests on darwin-arm64.

### Change Summary

Only this record changed: the stale v0.1.1 targets in Current state, Steps and Verify now name v0.2.0, the release the formula actually pins since bot PR #6 (`6f34b15`). KI Website lists `techne` since its PR #14 (`5320886`), outside this item's boundary.

### Verification

- `gh release view v0.2.0 -R knowledgeislands/tools-techne`: immutable, not a prerelease; the three archive digests and `techne-checksums.txt` match every `sha256` in `Formula/techne.rb`.
- `brew style Formula/techne.rb`: no offences.
- `brew audit --strict --online knowledgeislands/tap/techne`: pass.
- `brew install --build-from-source knowledgeislands/tap/techne` and `brew test`: pass (`--version`, `diag --json`, bash and zsh completion).
- `/opt/homebrew/bin/techne --version`: `0.2.0`; `diag --json` reports `"installation":"release"`.
- `ruby test/tool_release_events_test.rb` (11 runs) and `ruby test/propose_tool_release_test.rb` (7 runs): 0 failures.
- `ki repo audit --repo .`: PASS.

The local Homebrew tap clone was fast-forwarded to `a881698` first, and `techne` was uninstalled from Homebrew afterwards to restore the machine's prior state.

### Outstanding concerns

None. Linux-x64 installation was checked only by checksum, not by a local install.

### Post-change review

The goal is met: an immutable Techne release is packaged with verified checksums and installs correctly. Scope held; the only drift was the record's own stale version. Regression risk is nil. Ready for acceptance.

### Mini recap

The v0.2.0 Techne formula passes style, strict online audit, install, test and offline smoke checks, with checksums matching the published release. No concerns. Learning route: none.

## Discussion

### Repository boundary

`tools-techne` owns source release creation and artifact integrity. Homebrew Tap owns formula syntax, platform selection, checksum binding, installation tests, and tap documentation once those immutable inputs exist.

### Adoption condition

Shape this item only after `tools-techne` publishes the reviewed semantic-version release and all supported archive checksums are observable. Verification should include formula audit, install, `techne --version`, and offline `techne diag --json` evidence.

### Planning - 2026-10-05

Decided by the Fable reviewer under delegated autonomy, reversible: the existing v0.1.1 formula is the delivery, so no new formula work is planned. Adopted from Triage to `now` and made Ready; delivery is local verification and evidence recording. Nothing is published or tagged.
