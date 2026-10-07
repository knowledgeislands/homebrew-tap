---
id: BREW-012
title: Document release app operations
kind: deliver
purpose: governance
project: estate-factorisation
horizon: now
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-06T23:04:43Z
updated_at: 2026-10-07T20:38:35Z
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

Adopted into Now on 2026-10-07 under decision 17 of the state-of-play design; not yet planned. The tap has no `docs/guides/` directory, so the guide's location is unconfirmed. The release workflows on `main` are `.github/workflows/ci.yml` and `.github/workflows/propose-tool-releases.yml`. The salvaged sender-side draft is at `~/.local/state/ki/state-of-play/salvage/release-app/homebrew-tap/0001-docs-releases-document-release-app-operations.patch` and predates ODR-KI-WEBSITE-001 and the Arcadia GitHub Apps note.

## Steps

- [ ] Re-check the salvaged draft against the current workflows, the consumer registry and the Arcadia GitHub Apps note, and narrow it to what the tap owns.
- [ ] Confirm the guide's location under this repository's declared documentation shape.
- [ ] Write the sender-side operations guide: consumer onboarding and removal, credential presence checks without reading values, retry and replay, `403`/`404` and token-mint diagnosis, key revocation and compromise response, citing the Arcadia note for custody and rotation.
- [ ] Reconcile the three disagreements in Context, routing any change outside this repository to its owner rather than editing it here.

## Files touched

The new operations guide and `CLAUDE.md`'s onboarding paragraph, which should point to the guide. Changes in other repositories are routed to their owners, not made here.

## Verify

1. `ki repo audit` passes in this repository.
2. The guide covers every in-scope topic in Boundary and cites, rather than copies, the Arcadia key-custody and rotation procedure.
3. Each of the three disagreements in Context is resolved here or has a named owner record.

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

## Discussion

The salvaged drafts predate ODR-KI-WEBSITE-001 (2026-10-05) and the Arcadia note, so they must be re-checked against current workflows and narrowed to what the tap owns rather than landed as written.
