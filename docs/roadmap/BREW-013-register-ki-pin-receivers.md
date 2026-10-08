---
id: BREW-013
title: Register ki pin receivers
status: triage
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-08T09:40:00Z
updated_at: 2026-10-08T09:40:00Z
---

## Goal

Each repository that adopts the released `ki` pin receiver is registered in `.github/tool-release-consumers.json`, so a `ki` release reaches it within minutes rather than at its daily schedule.

## Context

`ki-agentic-harness` KI-HARNESS-GOV-141 stated the receiver contract in the `ki-engineering` standard: a repository keeps its released `ki` tag in `.github/ki-version`, and its `.github/workflows/update-ki-pin.yml` receiver re-reads the latest immutable `tools-ki` release and opens a reviewed pin-bump pull request. The receiver accepts the tap's existing `tool-release-published` event unchanged and treats it only as a trigger, so the registry and its payload need no change. The harness adopted the receiver itself.

A receiver runs only once the release App is installed on its repository and the repository holds `KI_TOOLS_RELEASE_BOT_APP_ID` and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY`; until then its job is skipped. Registering a repository before its installation would fail the tap's token mint for every consumer, as the release App operations guide explains.

Originating repository and item: `ki-agentic-harness` KI-HARNESS-GOV-141, which this item does not block.

## Boundary

In scope: registry entries for repositories whose receiver is merged and whose App installation and credentials the organisation owner has provisioned, each followed by a replay. Out of scope: the receivers themselves, which each repository owns, and every App or credential step, which is reserved for the organisation owner.

## Discussion

- No repository is ready yet: the harness receiver awaits its App installation and credentials. Plan through `ki-plan` once one is provisioned.
- Verify by the release-event tests and a replayed `ki` release reaching each newly registered receiver, which exits without a pull request when its pin is current.
