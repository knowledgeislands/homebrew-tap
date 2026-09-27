---
id: BREW-002
title: Review audit findings
theme: formula-coverage
horizon: future
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-09-04T08:53:43Z
updated_at: 2026-09-27T23:12:11Z
---

## Goal

Discuss the unresolved estate-audit finding before deciding whether remediation is warranted.

## Context

The audit reported `ki-housekeeping-claude` criterion `IDX-1`: the expected Claude memory index is absent.

## Boundary

This is a discussion proposal only. It is not accepted, prioritised, or implementation authority.

## Shaping

Confirm whether the memory index belongs in this repository, whether an exception applies, and what evidence would close the finding.

## Discussion

Review the focused evidence before choosing to add the index, document an exception, or leave the finding unresolved.

### Pickup checkpoint — 2026-09-28

At inspected local `main` `e56d2a7744eecd3063ab30d72778d2c7590a16b0`, `ki repo audit --skill ki-housekeeping-claude --repo .` reported PASS, as did the full `ki repo audit --repo .` across 18 selected skills. `.ki.toml` now declares `auto_memory = "disabled"` for `ki-housekeeping-claude`, following `e6bce12`; the old `IDX-1` missing-index finding is therefore historical audit evidence, not a current focused failure. These results do not show that a memory index was created or constitute an accepted choice to remediate, document an exception, or close the proposal. The original audit evidence beyond this record's criterion summary was not recovered. Before resuming discussion or implementation, reconcile the destination branch, linked tasks, and retained worktrees and confirm which policy and finding still apply. This checkpoint is pickup guidance, not an execution block or authority grant; absent evidence does not release any owner or lift a hold. This audit leaves `future`/`draft` unchanged; later closure requires review and explicit owner acceptance, with the done record retained until explicit pruning selection.
