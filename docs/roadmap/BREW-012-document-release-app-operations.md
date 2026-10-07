---
id: BREW-012
title: Document release app operations
kind: deliver
purpose: governance
project: estate-factorisation
status: triage
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-06T23:04:43Z
updated_at: 2026-10-07T14:11:21Z
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

## Discussion

The salvaged drafts predate ODR-KI-WEBSITE-001 (2026-10-05) and the Arcadia note, so they must be re-checked against current workflows and narrowed to what the tap owns rather than landed as written.
