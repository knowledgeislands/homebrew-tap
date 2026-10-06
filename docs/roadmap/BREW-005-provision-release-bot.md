---
id: BREW-005
title: Provision release bot
theme: formula-coverage
horizon: now
status: awaiting-review
blocks: []
blocked_by: []
baseline_ref: a8816988e067dd87c2be75e971009ef6d7d92751
created_at: 2026-09-20T07:34:49Z
updated_at: 2026-10-06T01:12:00Z
---

## Goal

Activate the reviewed generic tool-release fanout with a shared GitHub App and prove one end-to-end release event reaches an explicitly configured consumer.

## Context

Homebrew Tap owns the release-event registry, dispatch workflow, and sender credentials. The implementation and hosted review gates pass, but live dispatch remains fail-closed until the App is installed for configured consumers and `KI_TOOLS_RELEASE_BOT_APP_ID` plus `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` are configured for the tap workflow.

Each consumer repository independently owns its receiver workflow and installation consent. KI Website is the first configured consumer.

## Boundary

Do not commit credentials, broaden the App beyond listed consumers, grant merge or deployment authority, or make Homebrew Tap own consumer-side policy. Provisioning must preserve the existing bounded evidence event and each receiver's independent validation and review boundary.

## Current state

The waiting condition is met. The shared App `ki-tools-release-bot` exists and is installed in the organisation for selected consumer repositories; `KI_TOOLS_RELEASE_BOT_APP_ID` (variable) and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` (secret) were set on this repository on 2026-09-20; the secret was last updated on 2026-10-05. Live dispatch has run: tap CI run `37069215625` (Techne v0.1.1 formula, 2026-10-02) dispatched, and KI Website's `Update tool release` workflow received it (run `37069258529`, rejected on the website's own policy because it had no `techne` entry) without merge or deployment; KI Website run `37064013812` received an earlier dispatch successfully.

## Steps

- [x] Take `baseline_ref`.
- [x] Re-confirm the setting evidence by name and date only - never values - with `gh variable list` and `gh secret list`.
- [x] Re-confirm the dispatch and receipt run IDs above with `gh run view`, and that no website run merged or deployed.
- [x] Record the evidence under `## Discussion` in this record and move it to Awaiting review. No setting, credential or App change is made.

## Files touched

- This roadmap record only.

## Verify

```sh
gh variable list -R knowledgeislands/homebrew-tap
gh secret list -R knowledgeislands/homebrew-tap
gh run view 37069215625 -R knowledgeislands/homebrew-tap --json conclusion,jobs
gh run list -R knowledgeislands/ki-website --workflow update-tool-release.yml -L 5
ki repo audit --progress never
```

The evidence shows both settings present (no values), one successful tap dispatch, and website receipt with no automatic merge or deployment.

## Dependencies / blocks

Blocks nothing. Remaining automation ambitions - App installation on this repository for PR-opening intake, branch rules and auto-merge - belonged to BREW-007, which was delivered and later pruned (`1195e49`).

## Documentation impact

### Decision Records

None; the shared App policy is already recorded.

### Specifications

None.

### Guides

Naming the App and fail-closed dispatch in the release guide is carried by BREW-007.

### Roadmap

Close with the recorded evidence.

## Review

### Delivered

Evidence-only delivery within the boundary: no setting, credential, App installation or consumer policy was changed. Baseline `a8816988e067dd87c2be75e971009ef6d7d92751`. The shared App `ki-tools-release-bot` is configured for this repository, has dispatched real release events, and KI Website has received them through its own receiver workflow.

### Change Summary

Only this record changed: Steps ticked, the evidence recorded, and the dangling BREW-007 link replaced with its prune commit. The live-chain evidence captured by BREW-010, which was disposed as merged into this item, is folded into the Discussion below. Deviation from the original completion wording: KI Website's receipt PRs now auto-merge behind the website's own ruleset (KI-WEB-SITE-042), a consumer-side decision; the tap neither granted nor exercises that merge authority beyond its own formula PRs from BREW-007.

### Verification

- `gh variable list -R knowledgeislands/homebrew-tap`: `KI_TOOLS_RELEASE_BOT_APP_ID` present, updated 2026-09-20.
- `gh secret list -R knowledgeislands/homebrew-tap`: `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` present, updated 2026-10-05. Names and dates only; no values were read.
- `gh run view 37069215625`: success on `2971210`; `KI governance` and `Notify release consumers` succeeded.
- `gh run list -R knowledgeislands/ki-website --workflow update-tool-release.yml`: `repository_dispatch` receipts `37064013812` (success), `37069258529` (failure, website policy had no `techne` entry), and on 2026-10-06 `37392659293` and `37395187477` (success). Run `37395187477` ran only `prepare-pull-request`; no deployment job ran in the receiver.
- `ki repo audit --repo .`: PASS.

### Outstanding concerns

None for this item. Registering further consumers (repositories pinning `KI_VERSION`) is separate planned work, not a gap in this provisioning.

### Post-change review

The goal is met: the shared App is active for the tap's fanout, and repeated real release events reached KI Website. Scope held to evidence recording. Regression risk is nil, as nothing executable changed. Ready for acceptance.

### Mini recap

Release-bot provisioning is evidenced by both settings present, a successful tap dispatch, and successful website receipts, including the v0.6.1 chain on 2026-10-06. No concerns. Learning route: none.

## Discussion

### Operational ownership

Keep sender configuration with Homebrew Tap because formula release events originate there and its committed registry determines fanout. Treat the GitHub App as shared organisation infrastructure, while every consumer retains authority over installation and receiver behaviour.

### Completion evidence

Completion needs repository-setting evidence without secret values, one successful dispatch from a real tool release or bounded test event, and observable receipt by KI Website without automatic merge or deployment.

### Former waiting condition

The item waited for the shared GitHub App identity, KI Website's approval of its installation, and the two settings on this repository. All three were observed on 2026-10-05.

### Planning - 2026-10-05

Adopted from Waiting for to `now` and made Ready by the Fable reviewer under delegated autonomy, reversible: the completion evidence already exists, so delivery is verification and recording only.

### Live chain evidence

The full chain ran on 2026-10-06 for tools-ki v0.6.1 (immutable, published 00:37 UTC): tap `Propose tool releases` run `37394956279` (`repository_dispatch`) opened bot PR #9, which auto-merged as `af97e02`; the post-merge `CI` run `37395106713` succeeded including `Notify release consumers`; KI Website run `37395187477` received the event and its bot PR #13 auto-merged. Earlier bot formula PRs #4-#8 and website PRs #8-#12 followed the same route. This evidence came from BREW-010, disposed as merged into this item.
