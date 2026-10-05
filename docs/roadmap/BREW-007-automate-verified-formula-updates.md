---
id: BREW-007
title: Automate verified formula updates
theme: formula-coverage
horizon: waiting-for
status: draft
blocks: []
blocked_by: [BREW-008]
baseline_ref: null
created_at: 2026-10-03T03:56:54Z
updated_at: 2026-10-05T08:30:00Z
---

## Goal

Turn an authorised immutable `tools-*` release into an exact Homebrew formula update through the shared GitHub App, with CI-gated automatic acceptance for routine updates.

## Context

Today the tap dispatches a verified event after a formula reaches `main`, but source releases do not propose their own formula changes. Its CI audits the repository and release-event extraction but does not run the Homebrew formula gates required by `AGENTS.md`. GitHub currently reports auto-merge disabled, and no required-check branch protection or ruleset was observed. Therefore automatic merge is not safe to enable yet. The existing `mgit` formula is at `v0.13.0` while its source release is `v0.14.0`; that older source release is mutable, so it must not be silently promoted as an immutable eligible event.

## Boundary

The upstream tool owns release publication and artifact identity. This tap owns formula metadata, checksums, PR validation and downstream event dispatch. A published, authorised and immutable release supplies standing authority for this exact receiving update, but not for unrelated changes or a local agent push. Do not auto-merge first-time formulae, unexpected diffs, failed checks, mutable releases or ambiguous versions. Do not dispatch website events until a validated formula actually lands on `main`.

## Current state

Both workflows - scheduled release intake and changed-formula CI with Homebrew gates - are committed and active on GitHub, and the Homebrew formula gates passed on the last changed-formula push (`2971210`, run `37069215625`). Three gaps remain. The `ki-tools-release-bot` App is installed in the organisation but not on this repository, so the scheduled `Propose tool releases` workflow fails creating its token (for example run `37268636528`). `CI` on `main` has failed since 2026-10-04 on the retired `ki manage diag` command, tracked in [BREW-008](BREW-008-fix-ci-diag-command.md). GitHub reports `allow_auto_merge: false`, no rulesets and no branch protection. The latest `mgit`, `rig` and `git-almanac` releases are mutable and correctly skipped, so live proof needs a future immutable `ki` or `techne` release.

## Steps

- [x] Implement enrolled immutable-release intake and exact formula PR generation, including idempotent and rejection cases.
- [x] Put changed-formula Homebrew checks into CI.
- [ ] Publish the workflows and make changed-formula checks required without App bypass.
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

Waiting for the local workflow commits to reach GitHub, the shared App to be confirmed with tap Contents and Pull requests write permissions, and `main` to require passing governance and Homebrew formula gates without App bypass. Then enable auto-merge and prove a qualifying immutable source release reaches a guarded formula merge and website dispatch. Existing mutable releases do not qualify.

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

### Local preparation

The scheduled intake is intentionally PR-only. Its source release check rejects mutable and prerelease entries, and its existing-formula boundary leaves first-time formulae for manual review. The Homebrew job is configured but cannot count as a required hosted check until branch rules are installed and a changed-formula PR proves it passes.

### Owner question - 2026-10-05

Triaged by the Fable reviewer as needing Kris: App installation, branch rules and auto-merge are repository-setting and credential choices, parallel to KI Website's [KI-WEB-SITE-042](https://github.com/knowledgeislands/ki-website/blob/main/docs/roadmap/KI-WEB-SITE-042-auto-accept-verified-tool-versions.md). The item stays in Waiting for until answered and until BREW-008 is green.

**Question for Kris:** Will you (a) add homebrew-tap to the `ki-tools-release-bot` App installation, (b) add a `main` ruleset requiring pull requests and the `KI governance` and `Homebrew formula gates` checks, with repository admins as the only bypass actor (no App bypass), and (c) enable `allow_auto_merge` on the tap? Recommended: yes to all three, applied after BREW-008 is green on `main`. The intake opens exact-update PRs only for immutable releases, and auto-merge stays gated by both checks.
