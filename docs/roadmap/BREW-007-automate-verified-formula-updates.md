---
id: BREW-007
title: Automate verified formula updates
theme: formula-coverage
horizon: now
status: done
blocks: []
blocked_by: [BREW-008]
baseline_ref: 7e5fbdea9a686bd96b68a490704642bc89c26216
created_at: 2026-10-03T03:56:54Z
updated_at: 2026-10-05T11:32:00Z
---

## Goal

Turn every published immutable release of a tapped tool into an exact Homebrew formula update that merges itself once the tap's required checks pass, using the shared `ki-tools-release-bot` App end to end.

## Context

The tap already holds a PR-only intake (`propose-tool-releases.yml`) that polls each formula's latest release every three hours, rejects mutable, prerelease and first-time cases, and opens an exact-update PR; changed-formula CI runs the Homebrew gates. Nothing is event-driven, auto-merge is off, and `main` has no ruleset. [BREW-008](BREW-008-fix-ci-diag-command.md) restored green `CI` on `main` (run `37296407275`, checks `KI governance` and `Homebrew formula gates` from GitHub Actions, integration `15368`). The intake currently fails at token creation because the App is not installed on this repository (run `37268636528`).

Owner decision (Kris, 2026-10-05, "I thought that was the point of the release-bot"): releases notify the tap by `repository_dispatch` through the release bot; the tap proposes and auto-merges the formula PR; the immutable release is the manual gate and everything downstream is acceptable. Kris approved the ruleset and `allow_auto_merge` change via `gh api`.

## Boundary

In scope:

- Tap intake triggers: `repository_dispatch` type `tool-release-published`, a daily cron backstop replacing the three-hourly one, and `workflow_dispatch`. A dispatch is validated (enrolled source repository, `vX.Y.Z` tag) and then runs the same full latest-release scan, so a dropped or superseded dispatch is harmless; a workflow-level concurrency group serialises runs.
- `gh pr merge --auto --squash` on each formula PR the intake opens.
- A `main` ruleset requiring a pull request (no approvals, squash only) and the `KI governance` and `Homebrew formula gates` checks, with the repository admin role as the only bypass actor, plus `allow_auto_merge=true`, applied with `gh api`.
- A release-bot dispatch to the tap from each tapped tool repository: a `notify-homebrew-tap` job after publication in the `release.yml` of tools-ki, tools-techne and tools-git-almanac (their releases are created with `GITHUB_TOKEN`, which cannot trigger `release` events), and a small `release: published` workflow in tools-mgit and tools-rig (released manually by Kris). The job runs only when `KI_TOOLS_RELEASE_BOT_APP_ID` is visible, so releases stay green before Kris provisions credentials.
- One-sentence downstream notes in each tool's release guide, and the tap README intake paragraph.

Out of scope: installing the App or provisioning its ID and key (Kris-only), the tools-ki checkout pin ([BREW-009](BREW-009-pin-tools-ki-checkout.md)), consumer dispatch and the website receiver, first-time formulae, and any change to the proposal script's eligibility rules. The intake's fail-closed rules (immutable, non-prerelease, single forward version, declared asset URLs, existing formula only) remain the guard on what auto-merges. Tool repositories have no tap-to-tool work route, so their workflow edits are direct local commits per repository, skipping any repository whose workflow file is dirty.

## Current state

- `propose-tool-releases.yml`: schedule `17 */3 * * *` plus `workflow_dispatch`; PR body says human review is required.
- GitHub: `allow_auto_merge=false`, squash-only merges, no rulesets; Kris (`krisb`) is admin.
- Tool releases: ki `v0.5.1` and techne `v0.1.1` immutable (workflow-published); git-almanac `v0.1.0` (tag-push workflow), mgit `v0.14.0` and rig `v0.2.0` (manual) mutable. Immutable releases are enabled on all five repositories. None of the tool repositories has the App variable or secret.
- All six repositories pass `ki repo audit`. tools-ki has an unrelated dirty decision record, left untouched.

## Steps

- [x] Take `baseline_ref`.
- [x] Tap: change intake triggers, add payload validation and concurrency, enable auto-merge on opened PRs, update the PR body and README.
- [x] Tools: add the guarded `notify-homebrew-tap` dispatch to tools-ki, tools-techne and tools-git-almanac `release.yml`, and `notify-homebrew-tap.yml` to tools-mgit and tools-rig; add the downstream sentence to each release guide; actionlint, audit, commit, rebase and push each repository separately.
- [x] Apply `allow_auto_merge=true` and the `main` ruleset with `gh api`; read both back.
- [x] Commit and push the tap change (an admin bypass push) and confirm `CI` on `main` is green under the ruleset.
- [x] Capture the live end-to-end proof, which needs Kris's App installation and credentials, as a follow-up record ([BREW-010](BREW-010-prove-live-release-intake.md)).

## Files touched

- `.github/workflows/propose-tool-releases.yml`, `README.md`, this record and a follow-up record (homebrew-tap)
- `.github/workflows/release.yml` and `docs/guides/developer/releasing.md` (tools-ki, tools-techne, tools-git-almanac)
- `.github/workflows/notify-homebrew-tap.yml` and `docs/guides/developer/releasing.md` (tools-mgit, tools-rig)
- GitHub repository settings and ruleset for homebrew-tap

## Verify

```sh
mise x actionlint@1.7.12 -- actionlint <each changed workflow>
ruby test/propose_tool_release_test.rb && ruby test/tool_release_events_test.rb
ki repo audit --progress never   # in all six repositories
gh api repos/knowledgeislands/homebrew-tap --jq .allow_auto_merge   # true
gh api repos/knowledgeislands/homebrew-tap/rulesets/<id>   # PR + two checks, admin-only bypass
gh run list -R knowledgeislands/homebrew-tap --workflow CI -L 1   # success after the bypass push
```

A live dispatch, PR and auto-merge cannot run until Kris installs the App and provisions its credentials; that proof belongs to the follow-up record.

## Dependencies / blocks

[BREW-008](BREW-008-fix-ci-diag-command.md) is done. Live operation depends on Kris installing `ki-tools-release-bot` on homebrew-tap with Contents and Pull requests write, and exposing `KI_TOOLS_RELEASE_BOT_APP_ID` and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` to the five tool repositories.

## Documentation impact

### Decision Records

None; Kris's decision is recorded here.

### Specifications

None.

### Guides

Tap README intake paragraph; each tool's release guide gains the automatic tap dispatch.

### Roadmap

This record and the live-proof follow-up.

## Review

### Delivered

Kris's 2026-10-05 decision within the planned boundary: event-driven tap intake (`repository_dispatch` `tool-release-published`, daily `17 6 * * *` backstop, `workflow_dispatch`), squash auto-merge on every formula PR the intake opens, a `main` ruleset with admin-only bypass, `allow_auto_merge=true`, and release-bot dispatch jobs in the five tapped tool repositories. Excluded: App installation and credentials (Kris-only), the tools-ki pin ([BREW-009](BREW-009-pin-tools-ki-checkout.md)), consumer dispatch and eligibility rules. Baseline `7e5fbdea9a686bd96b68a490704642bc89c26216`.

### Change Summary

- homebrew-tap `.github/workflows/propose-tool-releases.yml`: new triggers, a non-cancelling `propose-tool-releases` concurrency group, a dispatch validation step (tag must be `vX.Y.Z`, repository must be a formula `source_repository`) before the unchanged full scan, a revised PR body and `gh pr merge "$branch" --auto --squash` immediately after PR creation. `README.md` intake paragraph rewritten.
- tools-ki `91fa4e3`, tools-techne `4485929`, tools-git-almanac `b3b5249`: `notify-homebrew-tap` job in `release.yml` after publication (needs `validate, publish`, or `release` for git-almanac), `permissions: {}`, App token scoped to homebrew-tap via `actions/create-github-app-token` pinned to `fee1f7d` (v2.2.2), dispatch payload `{repository, tag}`, skipped while `vars.KI_TOOLS_RELEASE_BOT_APP_ID` is empty. Release guide paragraph added.
- tools-mgit `926e38d`, tools-rig `fa0b187`: new `notify-homebrew-tap.yml` on `release: published` (non-prerelease) with the same job; release guide paragraph added.
- GitHub: `allow_auto_merge=true`; ruleset `Protect main` (id `24497437`, active, `~DEFAULT_BRANCH`): pull request with zero approvals and squash only, required checks `KI governance` and `Homebrew formula gates` from integration `15368` without strict up-to-date policy, plus deletion and non-fast-forward protection; bypass `RepositoryRole` admin (`5`), always. The deletion and non-fast-forward rules are a small, admin-bypassable addition to the planned shape.
- Captured [BREW-010](BREW-010-prove-live-release-intake.md) in Triage for the live proof.

### Verification

- `actionlint` 1.7.12: tap workflows and all five tool workflows clean.
- `ruby test/propose_tool_release_test.rb` (7 runs) and `ruby test/tool_release_events_test.rb` (11 runs): 0 failures.
- `ki repo audit --progress never`: PASS in tools-ki (22 skills), tools-techne (19), tools-git-almanac (21), tools-mgit (19), tools-rig (20) before their commits, and in homebrew-tap (17) before this commit.
- `gh api repos/knowledgeislands/homebrew-tap/rules/branches/main`: `deletion`, `non_fast_forward`, `pull_request`, `required_status_checks`; `allow_auto_merge` reads back `true`.
- Each tool commit touches only its workflow and release guide.
- Post-push `CI` on `main` under the ruleset: run `37299678913` on `0ac4af2` succeeded.

### Outstanding concerns

- Live operation awaits Kris: install the App on homebrew-tap and provide the App ID and key to the tool repositories; until then the tap's scheduled intake keeps failing at token creation and the notify jobs are skipped. BREW-010 owns the proof.
- tools-ki `release.yml` `verify-release-install` called the retired `ki manage diag`, so the next tools-ki release would have failed that job after publication; tools-ki owns the fix and delivered it as `KI-TOOL-CLI-103` in tools-ki `20f99e6` (accepted in `e5bb8ff`), which moves both its CI and release verification to `ki diag`. The tap notify job never depended on it.
- mgit `v0.14.0`, rig `v0.2.0` and git-almanac `v0.1.0` are mutable and stay skipped until their next immutable release.

### Post-change review

The goal - routine formula updates without human steps after an immutable release - is implemented across all six repositories; the eligibility guard is unchanged, so only exact forward updates to existing formulae can auto-merge, and they still need both checks. Regression risk is low: the notify jobs are no-ops until provisioned and run after publication, and admins keep direct-push access. Acceptance-ready on delivered scope; the live proof is deliberately split into BREW-010.

### Mini recap

Delivered event-driven intake, auto-merge and the `main` ruleset, with release-bot dispatch jobs in the five tool repositories committed separately. Static, test and audit gates pass. Learning routes: the tools-ki `ki manage diag` call, since fixed in tools-ki as `KI-TOOL-CLI-103` (`20f99e6`), and BREW-010 for live evidence.

## Done

Accepted 2026-10-05 on the review packet above, under the owner's delegated estate-push authority following independent Fable review against live state. The reviewer confirmed `allow_auto_merge=true`; ruleset `24497437` active with zero-approval squash-only pull requests, the two required checks from integration `15368`, a non-strict policy and admin-only bypass with no App actor; the intake triggers, dispatch validation, non-cancelling concurrency and `gh pr merge --auto --squash` at `0ac4af2` with eligibility rules unchanged; both Ruby suites and actionlint clean; CI run `37299678913` green; and the guarded, tap-scoped `notify-homebrew-tap` dispatch in all five tool repositories. Live end-to-end proof is not part of this acceptance: it awaits Kris's App installation and credentials and is owned by [BREW-010](BREW-010-prove-live-release-intake.md). Left at `done` for the owner's review.

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

### Owner decision and re-plan - 2026-10-05

Kris answered the owner question: the release bot exists to make this automatic. Releases dispatch to the tap, the tap opens and auto-merges exact formula PRs behind the two required checks, and the immutable release is the manual gate. Yes to the ruleset (admin-only bypass) and `allow_auto_merge`, applied via `gh api`. App installation and credential provisioning remain Kris's own steps. Re-planned to Ready under the coordinator's delegated estate authority.

### Plan review - 2026-10-05

Independent Fable plan review: APPROVE, with three implementation notes carried into delivery - set `strict_required_status_checks_policy: false` so auto-merge is not stalled by a sibling formula PR; give the intake concurrency group `cancel-in-progress: false`; call `gh pr merge --auto` immediately after PR creation. The notify jobs run outside any deployment environment, so the App ID and key must be repository- or organisation-level, not `release`-environment secrets.
