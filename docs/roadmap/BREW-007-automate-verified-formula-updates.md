---
id: BREW-007
title: Automate verified formula updates
theme: formula-coverage
horizon: next
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-03T03:56:54Z
updated_at: 2026-10-03T03:56:54Z
---

## Goal

Turn an authorised immutable `tools-*` release into an exact Homebrew formula update through the shared GitHub App, with CI-gated automatic acceptance for routine updates.

## Context

Today the tap dispatches a verified event after a formula reaches `main`, but source releases do not propose their own formula changes. Its CI audits the repository and release-event extraction but does not run the Homebrew formula gates required by `AGENTS.md`. GitHub currently reports auto-merge disabled, and no required-check branch protection or ruleset was observed. Therefore automatic merge is not safe to enable yet. The existing `mgit` formula is at `v0.13.0` while its source release is `v0.14.0`; that older source release is mutable, so it must not be silently promoted as an immutable eligible event.

## Boundary

The upstream tool owns release publication and artifact identity. This tap owns formula metadata, checksums, PR validation and downstream event dispatch. A published, authorised and immutable release supplies standing authority for this exact receiving update, but not for unrelated changes or a local agent push. Do not auto-merge first-time formulae, unexpected diffs, failed checks, mutable releases or ambiguous versions. Do not dispatch website events until a validated formula actually lands on `main`.

## Current state

Formula update proposals are manual and only post-merge consumer dispatch is automated. Required formula checks and protected auto-merge are absent.

## Steps

- [ ] Design enrolled immutable-release intake and exact formula PR generation, including retry and rejection cases.
- [ ] Put changed-formula Homebrew checks into CI and make them required without App bypass.
- [ ] Enable exact routine-update auto-merge while retaining human review for exceptions.
- [ ] Verify a bounded dry run and a future authorised live immutable release handoff.

## Files touched

- `.github/workflows/` release intake and CI workflows
- `scripts/` intake/validation implementation and tests
- Formula files only when a qualifying immutable release exists
- Tap developer release guidance and this roadmap record
- GitHub branch rules and App permissions

## Verify

Run the repository audit, release-event tests, changed-formula Homebrew gates, and positive/negative intake tests. Inspect required-check and App-bypass settings through GitHub. A real immutable release must prove the end-to-end merge and downstream event; a dry run alone is not live proof.

## Dependencies / blocks

No technical prerequisite prevents design and CI work. Activating auto-merge depends on passing formula gates, required branch rules, and App permission review. Existing mutable releases do not qualify.

## Documentation impact

### Decision Records

Record any material App-permission or branch-rule decision that cannot be captured by the shared release policy.

### Specifications

State exact-update eligibility and fail-closed rejection conditions if the tap has a release-event specification.

### Guides

Update the tap release procedure and clarify standing downstream authority only after the guarded path is implemented.

### Roadmap

Record the implementation and live integration evidence here.

## Discussion

### Implementation preparation

Design a tap-owned source-release intake that verifies repository enrolment, immutable GitHub release evidence, exact archive URL and checksum, and one version step before opening a GitHub App PR. Make changed-formula CI run `brew style`, `brew audit --strict --online`, a build-from-source installation and `brew test`. Protect `main` with those required checks and prevent App bypass before enabling exact-update auto-merge. Test rejected and retry cases. Preserve a human review route for first-time or exceptional changes. Confirm how existing mutable `mgit v0.14.0` will be superseded by a future immutable release rather than treating a checksum alone as enough.

### Receiver coordination

The website receives only the post-merge tap event. Its separate auto-acceptance boundary belongs to `ki-website`; this record does not alter it.
