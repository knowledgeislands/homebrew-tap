---
id: BREW-012
title: Document release app operations
kind: deliver
purpose: governance
project: estate-factorisation
horizon: now
status: awaiting-review
blocks: []
blocked_by: []
baseline_ref: d440857a5107d0ebb04549ca5f282be306acc3bb
created_at: 2026-10-06T23:04:43Z
updated_at: 2026-10-08T08:35:00Z
---

## Goal

A maintainer can diagnose and recover a failed tool-release notification, onboard or remove a consumer, and respond to a release-app key exposure by following one runbook, without reconstructing the procedure from scattered notes.

## Context

The tap owns the release-event extractor, the consumer registry `.github/tool-release-consumers.json`, the `notify-consumers` dispatch and the sender-side credentials of the shared `ki-tools-release-bot` GitHub App (BREW-005). On 2026-10-07 coverage of the App's operation on `main` across the estate was:

- **Provisioning and installation:** described in `ki-arcadia-principal` `Admin/Governance/Conventions/Admin Conventions/GitHub Apps.md` (permissions, selected installations, credential holders); `CLAUDE.md` here gives the onboarding rule in one paragraph. No step-by-step consumer onboarding or removal checklist.
- **Secrets and key rotation:** the Arcadia note owns key custody and a rotation procedure. Nothing says how to confirm credentials are present without reading them, or how to revoke a key.
- **Auto-merge:** fully decided in `ki-website` `docs/decisions/ODR-KI-WEBSITE-001-tool-release-updates-auto-merge.md`; it needs no extra App permission.
- **Failure, replay and recovery:** mentioned only - the manual `CI` run with the formula name (`CLAUDE.md`), idempotent receiver replay (`ki-website` `docs/guides/developer/tool-routes.md`). There is no diagnosis of a failed token mint or a `403`/`404` dispatch, and no key-compromise response.

The sources also disagree. The Arcadia note lists `homebrew-tap` as an installation target while `CLAUDE.md` says the App is installed only on listed consumers; the harness release-readiness standard says a tool repository stores no shared release-App credentials while five `tools-*` repositories hold them; and the Arcadia note says end-to-end proof awaits `BREW-010`, which is no longer on `main`.

Source: two unmerged runbook drafts written on 2026-09-20 and abandoned in the 2026-10-07 leftover cleanup:

- `homebrew-tap` branch `docs/release-app-operations`, commit `b38da15` (`docs(releases): document release app operations`) - a 60-line `docs/guides/tool-release-notifications.md` covering authority, credential locations, consumer onboarding, verify and retry, `403`/`404` diagnosis, rotation and compromise.
- `ki-website` branch `docs/release-app-receiver`, commit `3e8e1a7` (`docs(tooling): document release app operation`) - a receiver-side section that defers provisioning, onboarding, rotation and incident recovery to the tap guide.

Patch copies are kept at `~/.local/state/ki/state-of-play/salvage/release-app/`. Origin: the `ki-arcadia-principal` checkpoint `+/_CHECKPOINTS/state-of-play.md`.

## Boundary

In scope: a tap-owned operations guide for the release App's sender side - consumer onboarding and removal, credential presence checks, retry and replay, failure diagnosis, key revocation and compromise response - and reconciling the three disagreements above.

Out of scope: key custody and the rotation procedure, which the Arcadia note owns and the guide should cite rather than copy; each consumer's receiver behaviour; the auto-merge decision; and registering new consumers, which BREW-011 owns. App and credential steps remain Kris-only under BREW-005.

## Current state

Planned and started on 2026-10-08. The guide lives at `docs/guides/maintainer/release-app-operations.md` under the `ki-guides` collection root, which this repository adopts for it with a `docs/guides/README.md` index; its reader is the tap maintainer.

The salvaged draft was re-checked against `main`. Still true: the registry lists only `knowledgeislands/ki-website`, `notify-consumers` mints a token scoped to the registered consumers, and the manual `CI` run with a formula name replays a dispatch. Changed since the draft: `propose-tool-releases.yml` now mints a tap-scoped token and pushes formula branches, so the App is installed on the tap itself; five `tools-*` release workflows hold the App credentials to dispatch to the tap; the tap's daily schedule backstops a missed tool dispatch; and auto-merge is decided by ODR-KI-WEBSITE-001. The chain was proven end to end on 2026-10-07: the App opened and auto-merged tap formula PRs #23 to #29 and website PRs #24 to #28 for `ki` v0.8.1 to v0.9.0 and `mgit` v0.16.0.

The three disagreements resolve as follows:

1. **Installation targets.** The Arcadia note is right: the tap is an installation target because `propose-tool-releases.yml` mints a tap-scoped token. `CLAUDE.md` here is corrected in this item.
2. **Tool-repository credentials.** The tool repositories do hold the App variable and secret, for their tap-scoped dispatch. The harness release-readiness sentence is out of date; KI-HARNESS-GOV-141, which edits the same release-chain contract, owns its correction.
3. **End-to-end proof.** `BREW-010` is gone and the proof now exists. The Arcadia note's pointer is routed to KI-ARCADIA-GOV-030 in `ki-arcadia-principal`.

## Steps

- [x] Re-check the salvaged draft against the current workflows, the consumer registry and the Arcadia GitHub Apps note, and narrow it to what the tap owns.
- [x] Confirm the guide's location under this repository's declared documentation shape.
- [x] Adopt `ki-guides` in `.ki.toml` and add `docs/guides/README.md`.
- [x] Write the sender-side operations guide: the release chain, credential presence checks without reading values, consumer onboarding and removal, retry and replay, token-mint, `403`/`404` and proposal diagnosis, and key revocation and compromise response, citing the Arcadia note for custody and rotation.
- [x] Correct `CLAUDE.md`'s installation sentence and point it to the guide.
- [x] Route disagreement 3 to KI-ARCADIA-GOV-030; disagreement 2 is owned by KI-HARNESS-GOV-141.

## Files touched

`.ki.toml`, `docs/guides/README.md`, `docs/guides/maintainer/release-app-operations.md` and `CLAUDE.md`. Changes in other repositories are routed to their owners, not made here.

## Verify

1. `ki repo audit --repo .` passes, including `ki-guides`.
2. The release-event and proposal Ruby tests still pass.
3. The guide covers every in-scope topic in Boundary and cites, rather than copies, the Arcadia key-custody and rotation procedure.
4. Each of the three disagreements in Context is resolved here or has a named owner record.

## Dependencies / blocks

None blocking. App and credential steps remain Kris-only under BREW-005; consumer registration remains with BREW-011.

## Documentation impact

### Decision Records

None expected; the auto-merge decision is already recorded in ODR-KI-WEBSITE-001.

### Specifications

None; the guide documents operation, not a behaviour contract.

### Guides

Adds the tap's release-App operations guide.

### Roadmap

Any disagreement owned elsewhere becomes a handoff item in that repository.

## Review

### Delivered

The approved boundary: a sender-side release App operations guide under a new `ki-guides` collection, the `CLAUDE.md` correction and pointer, and the three disagreements resolved or routed. Baseline `d440857a5107d0ebb04549ca5f282be306acc3bb`.

### Change Summary

- `.ki.toml` adopts `ki-guides`; `docs/guides/README.md` indexes the collection.
- `docs/guides/maintainer/release-app-operations.md` covers the chain, credential presence checks, consumer onboarding and removal, retry and replay, a failure diagnosis table and key-exposure response, citing the Arcadia convention for custody and rotation.
- `CLAUDE.md` names the tap as an installation target and points to the guide.
- Disagreement 3 routed to KI-ARCADIA-GOV-030 (`ki-arcadia-principal` `f7afd69`); disagreement 2 owned by KI-HARNESS-GOV-141.

### Verification

- `ruby test/tool_release_events_test.rb`: 11 runs, 0 failures. `ruby test/propose_tool_release_test.rb`: 7 runs, 0 failures.
- `ki repo audit --repo .`: PASS, 18 skills including `ki-guides`.

### Outstanding concerns

None. The guide's `gh` commands and every App or credential step remain the organisation owner's to run.

### Post-change review

Scope stayed within the four planned files. No workflow, script or formula changed, so regression risk is nil.

### Mini recap

Delivered and verified; accepted under Kris's standing decision (Decision 17).

## Discussion

The salvaged drafts predate ODR-KI-WEBSITE-001 (2026-10-05) and the Arcadia note, so they must be re-checked against current workflows and narrowed to what the tap owns rather than landed as written.
