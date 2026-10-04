---
id: BREW-002
title: Review audit findings
theme: formula-coverage
horizon: next
status: ready
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-09-04T08:53:43Z
updated_at: 2026-10-04T12:16:13Z
---

## Goal

Discuss the unresolved estate-audit finding before deciding whether remediation is warranted.

## Context

The audit reported `ki-housekeeping-claude` criterion `IDX-1`: the expected Claude memory index is absent.

## Boundary

This is a discussion proposal only. It is not accepted, prioritised, or implementation authority.

## Current state

`.ki.toml` declares `auto_memory = "disabled"` under `[skills.ki-housekeeping-claude]`, set by the owner in `e6bce12` ("chore: disable reconciled Claude auto-memory"). With auto-memory disabled the skill expects no Claude memory index, and `ki repo audit --skill ki-housekeeping-claude --repo .` passes. The original `IDX-1` finding is therefore resolved by the owner's policy choice rather than by adding an index.

## Steps

- [ ] Confirm the memory index does not belong in this repository: auto-memory is disabled by owner policy, so `IDX-1` no longer applies.
- [ ] Confirm the closing evidence: the focused and full audits pass on current `main`, with no `IDX-1` finding.
- [ ] Record the resolution in this record; no repository file other than this record changes.

## Files touched

This record only.

## Verify

`ki repo audit --skill ki-housekeeping-claude --repo .` and `ki repo audit --repo .` report PASS with no `IDX-1` finding, and `.ki.toml` still declares `auto_memory = "disabled"` for `ki-housekeeping-claude`.

## Dependencies / blocks

None.

## Documentation impact

### Decision Records

None; the policy is the owner's committed `.ki.toml` setting.

### Specifications

None.

### Guides

None.

### Roadmap

This record only.

## Discussion

Review the focused evidence before choosing to add the index, document an exception, or leave the finding unresolved.

### Pickup checkpoint — 2026-09-28

At inspected local `main` `e56d2a7744eecd3063ab30d72778d2c7590a16b0`, `ki repo audit --skill ki-housekeeping-claude --repo .` reported PASS, as did the full `ki repo audit --repo .` across 18 selected skills. `.ki.toml` now declares `auto_memory = "disabled"` for `ki-housekeeping-claude`, following `e6bce12`; the old `IDX-1` missing-index finding is therefore historical audit evidence, not a current focused failure. These results do not show that a memory index was created or constitute an accepted choice to remediate, document an exception, or close the proposal. The original audit evidence beyond this record's criterion summary was not recovered. Before resuming discussion or implementation, reconcile the destination branch, linked tasks, and retained worktrees and confirm which policy and finding still apply. This checkpoint is pickup guidance, not an execution block or authority grant; absent evidence does not release any owner or lift a hold. This audit leaves `future`/`draft` unchanged; later closure requires review and explicit owner acceptance, with the done record retained until explicit pruning selection.

### Adoption

Adopted into `next` and shaped to Ready on 2026-10-04 under the owner's delegated estate-push authority. Of the three outcomes the Goal names, the owner's own `e6bce12` already chose the exception path by disabling Claude auto-memory, so this record closes on that evidence rather than adding an index.
