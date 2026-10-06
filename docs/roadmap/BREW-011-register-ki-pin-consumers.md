---
id: BREW-011
title: Register ki pin consumers
theme: formula-coverage
horizon: triage
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-06T01:22:00Z
updated_at: 2026-10-06T22:02:00Z
---

## Goal

Every repository that pins the released `ki` by `KI_VERSION` and implements the harness receiver contract is registered as a tap release consumer, so a `tools-ki` release reaches it through the existing `notify-consumers` dispatch.

## Context

`.github/tool-release-consumers.json` lists only `knowledgeislands/ki-website`. On 2026-10-06, 21 other repositories pinned `KI_VERSION: v0.6.1` in CI and none received the `tool-release-published` event, so each pin moved only by a manual edit. The tap owns the consumer registry, the dispatch and the sender credentials (BREW-005); the receiver contract a consumer must implement belongs to the KI Agentic Harness.

Raised by the 2026-10-06 estate roadmap consolidation (action A4).

## Boundary

In scope: adding receiver-ready repositories to the consumer registry, any registry or event-payload change the receiver contract needs, and confirming the release-bot App installation covers each registered consumer.

Out of scope: defining the receiver contract or adopting it in each consumer, which `ki-agentic-harness` owns under KI-HARNESS-GOV-141; and the App and credential steps themselves, which remain Kris-only under BREW-005.

## Discussion

### Cross-repository relationship

Blocked by `ki-agentic-harness` KI-HARNESS-GOV-141 (Auto-bump released ki pin): registering a repository before it has a receiver would dispatch events nobody handles. KI-HARNESS-GOV-141 records the reciprocal `blocks BREW-011`. The relationship is cross-repository, so it is held here in prose and the `blocked_by` field stays empty.

### Folded into KI-HARNESS-GOV-141

In the state-of-play review on 2026-10-06 (`ki-arcadia-principal`, `+/_CHECKPOINTS/state-of-play.md`), Kris approved merging this item into `ki-agentic-harness` KI-HARNESS-GOV-141, which was adopted into Next the same day and now carries this item's scope in its Context. A terminal `merged` disposition must name a target in this roadmap, so this record stays in Triage as a draft rather than closing. It holds no separate scope: the tap-side registry, payload and App-coverage work is planned under GOV-141 and delivered here when that plan places it. Close or respecify this record once GOV-141's plan settles the tap-side work.

### Open questions

- If the harness chooses central fan-out rather than per-repository receivers, the registry may need only one new consumer; this item should then be reshaped rather than register 21 repositories.
