---
id: BREW-013
title: Register ki pin receivers
status: cancelled
resolution: merged
resolution_target: KI-HARNESS-GOV-168
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-08T09:40:00Z
updated_at: 2026-10-09T21:03:23Z
---

## Goal

Each repository that adopts the released `ki` pin receiver is registered in `.github/tool-release-consumers.json`, so a `ki` release reaches it within minutes rather than at its daily schedule.

## Context

`ki-agentic-harness` KI-HARNESS-GOV-141 stated the receiver contract in the `ki-engineering` standard: a repository keeps its released `ki` tag in `.github/ki-version`, and its `.github/workflows/update-ki-pin.yml` receiver re-reads the latest immutable `tools-ki` release and opens a reviewed pin-bump pull request. The receiver accepts the tap's existing `tool-release-published` event unchanged and treats it only as a trigger, so the registry and its payload need no change. The harness adopted the receiver itself.

A receiver runs only once the release App is installed on its repository and the repository holds `KI_TOOLS_RELEASE_BOT_APP_ID` and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY`; until then its job is skipped. Registering a repository before its installation would fail the tap's token mint for every consumer, as the release App operations guide explains.

Originating repository and item: `ki-agentic-harness` KI-HARNESS-GOV-141, which this item does not block.

## Boundary

In scope: registry entries for repositories whose receiver is merged and whose App installation and credentials the organisation owner has provisioned, each followed by a replay. Out of scope: the receivers themselves, which each repository owns, and every App or credential step, which is reserved for the organisation owner.

## Cancelled

Cancelled 2026-10-09 as merged, approved by Kris Brown (state-of-play decisions log, Decision 21). `ki-agentic-harness` KI-HARNESS-GOV-168 (Roll out pin receivers), at `docs/roadmap/KI-HARNESS-GOV-168-roll-out-ki-pin-receivers.md` in that repository, now carries this record's registry entries in `.github/tool-release-consumers.json`, the replay after each registration and the release-event verification; it will send this repository a work trade for each registration once the receiver's App installation and credentials exist. It leaves no outstanding change here.

## Discussion

- No repository is ready yet: the harness receiver awaits its App installation and credentials. Plan through `ki-plan` once one is provisioned.
- Verify by the release-event tests and a replayed `ki` release reaching each newly registered receiver, which exits without a pull request when its pin is current.
