---
id: BREW-006
title: Package Techne CLI
theme: formula-coverage
horizon: now
status: ready
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-09-20T08:01:34Z
updated_at: 2026-10-05T08:25:00Z
---

## Goal

Package an immutable released Techne CLI in Homebrew Tap and verify the formula installs the correct platform artifact with its published checksum.

## Context

`tools-techne` now has an accepted local installer, diagnostic provenance, and release-packaging workflow, but no source release has been published. The tap must not add a placeholder or floating formula; it needs an observed immutable release archive and checksum from `tools-techne`.

## Boundary

Do not publish or tag `tools-techne` from this repository, invent checksums, point a formula at a branch or mutable asset, or make the tap own Techne runtime behaviour. This capture does not authorise formula publication or a tap release.

## Current state

The adoption condition is met and the formula exists. `tools-techne` v0.1.1 is published as an immutable, non-prerelease release with darwin-arm64, darwin-x64 and linux-x64 archives and checksums. `Formula/techne.rb` pins those three archives and their published checksums (commit `2971210`), and tap CI run `37069215625` passed on that commit.

## Steps

- [ ] Take `baseline_ref`.
- [ ] Confirm each `url` and `sha256` in `Formula/techne.rb` against the published v0.1.1 release assets (`gh release view v0.1.1 -R knowledgeislands/tools-techne --json assets,isImmutable` or equivalent and the published checksum file).
- [ ] Run the local Homebrew gates and the `techne` smoke checks in Verify on this machine.
- [ ] Record the evidence under `## Discussion` and move the record to Awaiting review. If any check fails, fix `Formula/techne.rb` within this boundary instead of recording delivery.

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

The brew-installed binary (not the local `~/.local/bin` link, which precedes Homebrew on PATH) prints `0.1.1`, and its `diag --json` runs offline and reports `"installation":"release"`, matching the formula's `test do`.

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

## Discussion

### Repository boundary

`tools-techne` owns source release creation and artifact integrity. Homebrew Tap owns formula syntax, platform selection, checksum binding, installation tests, and tap documentation once those immutable inputs exist.

### Adoption condition

Shape this item only after `tools-techne` publishes the reviewed semantic-version release and all supported archive checksums are observable. Verification should include formula audit, install, `techne --version`, and offline `techne diag --json` evidence.

### Planning - 2026-10-05

Decided by the Fable reviewer under delegated autonomy, reversible: the existing v0.1.1 formula is the delivery, so no new formula work is planned. Adopted from Triage to `now` and made Ready; delivery is local verification and evidence recording. Nothing is published or tagged.
