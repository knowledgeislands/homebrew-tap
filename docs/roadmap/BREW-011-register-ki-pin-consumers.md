---
id: BREW-011
title: Register ki pin consumers
kind: deliver
project: estate-factorisation
status: cancelled
resolution: merged
resolution_target: KI-HARNESS-GOV-141
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-06T01:22:00Z
updated_at: 2026-10-07T14:11:49Z
---

## Goal

Every repository that pins the released `ki` by `KI_VERSION` and implements the harness receiver contract is registered as a tap release consumer, so a `tools-ki` release reaches it through the existing `notify-consumers` dispatch.

## Context

`.github/tool-release-consumers.json` lists only `knowledgeislands/ki-website`. On 2026-10-06, 21 other repositories pinned `KI_VERSION: v0.6.1` in CI and none received the `tool-release-published` event, so each pin moved only by a manual edit. The tap owns the consumer registry, the dispatch and the sender credentials (BREW-005); the receiver contract a consumer must implement belongs to the KI Agentic Harness.

Raised by the 2026-10-06 estate roadmap consolidation (action A4).

## Boundary

In scope: adding receiver-ready repositories to the consumer registry, any registry or event-payload change the receiver contract needs, and confirming the release-bot App installation covers each registered consumer.

Out of scope: defining the receiver contract or adopting it in each consumer, which `ki-agentic-harness` owns under KI-HARNESS-GOV-141; and the App and credential steps themselves, which remain Kris-only under BREW-005.

## Cancelled

Cancelled 2026-10-07 as merged into KI-HARNESS-GOV-141, carrying out the fold Kris Brown approved in the state-of-play review on 2026-10-06 and re-confirmed on 2026-10-07, recorded under "Folded into KI-HARNESS-GOV-141" below; the migration proposals Kris approved on 2026-10-07 (decision 7) name the same closure. KI-HARNESS-GOV-141 already carries this item's scope in its Context, so this record holds no separate work. The target lives in `ki-agentic-harness` at `docs/roadmap/KI-HARNESS-GOV-141-auto-bump-released-ki-pin.md`. Outstanding changes: the tap-side registry, payload and App-coverage work is still to be delivered in this repository when GOV-141's plan places it, and the App and credential steps remain Kris-only under BREW-005. This closure does not edit GOV-141.

## Discussion

### Cross-repository relationship

Blocked by `ki-agentic-harness` KI-HARNESS-GOV-141 (Auto-bump released ki pin): registering a repository before it has a receiver would dispatch events nobody handles. KI-HARNESS-GOV-141 records the reciprocal `blocks BREW-011`. The relationship is cross-repository, so it is held here in prose and the `blocked_by` field stays empty.

### Folded into KI-HARNESS-GOV-141

In the state-of-play review on 2026-10-06 (`ki-arcadia-principal`, `+/_CHECKPOINTS/state-of-play.md`), Kris approved merging this item into `ki-agentic-harness` KI-HARNESS-GOV-141, which was adopted into Next the same day and now carries this item's scope in its Context. A terminal `merged` disposition must name a target in this roadmap, so this record stays in Triage as a draft rather than closing. It holds no separate scope: the tap-side registry, payload and App-coverage work is planned under GOV-141 and delivered here when that plan places it. Close or respecify this record once GOV-141's plan settles the tap-side work.

### Fold re-confirmed (2026-10-07)

On 2026-10-07 Kris confirmed this fold again in the `ki-arcadia-principal` state-of-play review. It still cannot be carried out as a `merged` disposition: `ki-accept` requires the target to resolve in this roadmap, and KI-HARNESS-GOV-141 lives in `ki-agentic-harness`. The skills allow two routes. Kris approves a `rejected` Triage disposition whose rationale records that the scope now lives in KI-HARNESS-GOV-141, closed through `ki-accept`; or this record stays in Triage until GOV-141's plan places the tap-side work, and is then respecified or closed. Nothing else changes here until Kris chooses.

### Open questions

- If the harness chooses central fan-out rather than per-repository receivers, the registry may need only one new consumer; this item should then be reshaped rather than register 21 repositories.

### Fold carried out (2026-10-07)

The roadmap model replaced the same-roadmap target rule with cancellation and a cross-repository `resolution_target`, so the fold is carried out directly as a `merged` resolution; see Cancelled.
