---
id: BREW-007
title: Automate verified formula updates
theme: formula-coverage
horizon: now
status: ready
blocks: []
blocked_by: [BREW-008]
baseline_ref: null
created_at: 2026-10-03T03:56:54Z
updated_at: 2026-10-05T10:50:00Z
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

- [ ] Take `baseline_ref`.
- [ ] Tap: change intake triggers, add payload validation and concurrency, enable auto-merge on opened PRs, update the PR body and README.
- [ ] Tools: add the guarded `notify-homebrew-tap` dispatch to tools-ki, tools-techne and tools-git-almanac `release.yml`, and `notify-homebrew-tap.yml` to tools-mgit and tools-rig; add the downstream sentence to each release guide; actionlint, audit, commit, rebase and push each repository separately.
- [ ] Apply `allow_auto_merge=true` and the `main` ruleset with `gh api`; read both back.
- [ ] Commit and push the tap change (an admin bypass push) and confirm `CI` on `main` is green under the ruleset.
- [ ] Capture the live end-to-end proof, which needs Kris's App installation and credentials, as a follow-up record.

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
