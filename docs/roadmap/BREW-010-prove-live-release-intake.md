---
id: BREW-010
title: Prove live release intake
theme: formula-coverage
horizon: triage
status: done
intake_disposition: merged
intake_disposition_target: BREW-005
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-05T10:56:00Z
updated_at: 2026-10-06T01:12:00Z
---

## Goal

Prove end to end that a published immutable tool release reaches the tap by `repository_dispatch`, opens an exact formula PR, auto-merges behind the required checks, and dispatches the post-merge consumer event.

## Context

BREW-007 (delivered, later pruned in `1195e49`) delivered the tap intake triggers, PR auto-merge, the `main` ruleset and `Notify Homebrew tap` dispatch jobs in tools-ki, tools-techne, tools-git-almanac, tools-mgit and tools-rig. Nothing can run live until Kris installs `ki-tools-release-bot` on homebrew-tap (Contents and Pull requests write) and makes `KI_TOOLS_RELEASE_BOT_APP_ID` and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` available to the five tool repositories at organisation or repository level.

## Boundary

Observation and evidence only: a manual `workflow_dispatch` of `Propose tool releases`, then the next real immutable release from a tapped tool. Fix-forward changes found during the proof become their own records. No credential handling by agents.

## Intake disposition

- **Outcome:** merged into [BREW-005](BREW-005-provision-release-bot.md), the retained canonical item.
- **Rationale:** both items prove the same release chain end to end, from a published tool release through the tap's formula PR and auto-merge to the post-merge consumer dispatch. BREW-005 is adopted and owns that proof, so this capture adds no separate outcome. Its live-chain evidence is recorded in BREW-005's Discussion rather than here.
- **Approval:** Kris Brown, through the roadmap-tidying autonomy he granted for the 2026-10-06 roadmap consolidation, exercised by its coordinator. This record was not adopted, planned or implemented.

## Done

Disposed 2026-10-06 by Kris Brown as merged on the intake evidence above.

## Discussion

### Capture - 2026-10-05

Captured at BREW-007 delivery so the live proof, which depends on Kris-only App and credential steps, does not hold BREW-007 open.
