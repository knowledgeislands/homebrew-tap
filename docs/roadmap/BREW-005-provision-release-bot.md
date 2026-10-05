---
id: BREW-005
title: Provision release bot
theme: formula-coverage
horizon: now
status: ready
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-09-20T07:34:49Z
updated_at: 2026-10-05T08:25:00Z
---

## Goal

Activate the reviewed generic tool-release fanout with a shared GitHub App and prove one end-to-end release event reaches an explicitly configured consumer.

## Context

Homebrew Tap owns the release-event registry, dispatch workflow, and sender credentials. The implementation and hosted review gates pass, but live dispatch remains fail-closed until the App is installed for configured consumers and `KI_TOOLS_RELEASE_BOT_APP_ID` plus `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` are configured for the tap workflow.

Each consumer repository independently owns its receiver workflow and installation consent. KI Website is the first configured consumer.

## Boundary

Do not commit credentials, broaden the App beyond listed consumers, grant merge or deployment authority, or make Homebrew Tap own consumer-side policy. Provisioning must preserve the existing bounded evidence event and each receiver's independent validation and review boundary.

## Current state

The waiting condition is met. The shared App `ki-tools-release-bot` exists and is installed in the organisation for selected consumer repositories; `KI_TOOLS_RELEASE_BOT_APP_ID` (variable) and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` (secret) were set on this repository on 2026-09-20. Live dispatch has run: tap CI run `37069215625` (Techne v0.1.1 formula, 2026-10-02) dispatched, and KI Website's `Update tool release` workflow received it (run `37069258529`, rejected on the website's own policy because it had no `techne` entry) without merge or deployment; KI Website run `37064013812` received an earlier dispatch successfully.

## Steps

- [ ] Take `baseline_ref`.
- [ ] Re-confirm the setting evidence by name and date only - never values - with `gh variable list` and `gh secret list`.
- [ ] Re-confirm the dispatch and receipt run IDs above with `gh run view`, and that no website run merged or deployed.
- [ ] Record the evidence under `## Discussion` in this record and move it to Awaiting review. No setting, credential or App change is made.

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

Blocks nothing. Remaining automation ambitions - App installation on this repository for PR-opening intake, branch rules and auto-merge - belong to [BREW-007](BREW-007-automate-verified-formula-updates.md).

## Documentation impact

### Decision Records

None; the shared App policy is already recorded.

### Specifications

None.

### Guides

Naming the App and fail-closed dispatch in the release guide is carried by BREW-007.

### Roadmap

Close with the recorded evidence.

## Discussion

### Operational ownership

Keep sender configuration with Homebrew Tap because formula release events originate there and its committed registry determines fanout. Treat the GitHub App as shared organisation infrastructure, while every consumer retains authority over installation and receiver behaviour.

### Completion evidence

Completion needs repository-setting evidence without secret values, one successful dispatch from a real tool release or bounded test event, and observable receipt by KI Website without automatic merge or deployment.

### Former waiting condition

The item waited for the shared GitHub App identity, KI Website's approval of its installation, and the two settings on this repository. All three were observed on 2026-10-05.

### Planning - 2026-10-05

Adopted from Waiting for to `now` and made Ready by the Fable reviewer under delegated autonomy, reversible: the completion evidence already exists, so delivery is verification and recording only.
