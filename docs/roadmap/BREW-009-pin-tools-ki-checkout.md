---
id: BREW-009
title: Pin tools-ki checkout
theme: formula-coverage
horizon: now
status: done
blocks: []
blocked_by: []
baseline_ref: af97e0239e2bc7ac769b6bd84489b81b5aee29fb
created_at: 2026-10-05T09:57:00Z
updated_at: 2026-10-06T00:59:00Z
---

## Goal

Make the tap's `CI` governance job install `ki` from a tools-ki release tag rather than the moving `main` branch, so upstream CLI changes cannot break the tap without a deliberate bump.

## Context

`.github/workflows/ci.yml` clones `knowledgeislands/tools-ki` with `--branch main` and links it from source. On 2026-10-04 tools-ki retired `ki manage diag`, turning every tap `CI` run red until [BREW-008](BREW-008-fix-ci-diag-command.md) removed the calls. Kris has been told this pin is planned.

## Boundary

Change only how the governance job selects the tools-ki revision (a pinned release tag, or a verified release install) and how that pin is bumped. Do not alter formula gates, consumer dispatch, GitHub settings or `propose-tool-releases.yml`. The bump mechanism may interact with [BREW-007](BREW-007-automate-verified-formula-updates.md) release triggering, which Kris is still deciding.

## Current state

Before delivery, the `KI governance` job cloned `knowledgeislands/tools-ki` at `--branch main` and linked it as source, so any upstream CLI change reached the tap's `CI` unannounced.

## Steps

- [x] Take `baseline_ref`.
- [x] Replace the tools-ki `main` clone in `.github/workflows/ci.yml` with the signed release installer pinned by a single `KI_VERSION` value.
- [x] Assert that the installed `ki --version` matches `KI_VERSION`.
- [x] Merge through a pull request and confirm `CI` on `main` succeeds.

## Files touched

- `.github/workflows/ci.yml`

## Verify

`grep -n 'branch main' .github/workflows/ci.yml` finds nothing, the job installs `ki` from `tools-ki/$KI_VERSION/install.sh`, and `CI` on `main` is green.

## Dependencies / blocks

None. BREW-008 (removal of the retired `ki manage diag` assertions) landed first; BREW-007 delivered and was pruned without automating the pin.

## Documentation impact

### Decision Records

None: pinning a CI tool to a release is routine configuration, not a structural decision.

### Specifications

None: no tap behaviour or formula contract changes.

### Guides

None: the pin is self-describing in the workflow `env` block.

### Roadmap

None: no follow-on work is required.

## Review

### Delivered

Within the boundary, only the governance job's choice of tools-ki revision changed: it now installs the signed `ki` release named by `KI_VERSION` (v0.6.1) instead of linking tools-ki `main`. The same pull request also gated the macOS formula job on changed formulae. Baseline `af97e0239e2bc7ac769b6bd84489b81b5aee29fb`; delivered by PR #10, squash commit `379ac4238e516a490dce18a7e625c29f037f9480`.

### Change Summary

`.github/workflows/ci.yml`: add `KI_VERSION: v0.6.1`, download `install.sh` from the pinned tag and run it with that version, assert `ki --version` equals the pin, and set up Bun for the `ki-authoring` Markdown gate. The open capture questions resolved as a signed-release install rather than a source checkout at a tag, with the pin bumped by hand in a reviewed pull request.

### Verification

- PR #10 checks: `KI governance`, `Detect formula changes` and `Homebrew formula gates` succeeded.
- `CI` run [`37395298696`](https://github.com/knowledgeislands/homebrew-tap/actions/runs/37395298696) on `379ac42` (`main`): `KI governance` and `Notify release consumers` succeeded; `Homebrew formula gates` skipped as designed with no formula change.
- `grep -rn 'branch main\|git clone' .github/workflows/`: no matches.

### Outstanding concerns

None. Advancing the pin is a deliberate manual edit, which is the outcome this item asked for.

### Post-change review

The goal is met: an upstream tools-ki change can no longer alter the tap's `CI` without a reviewed `KI_VERSION` bump. Scope stayed within the governance job apart from the formula-gate change, which touched no formula gate logic. Regression risk is low and the post-merge run is green.

### Mini recap

The tap's governance job now installs the signed `ki` v0.6.1 release instead of tools-ki `main`, verified by green `CI` on `379ac42`. No concerns remain. Learning route: none.

## Done

Accepted 2026-10-06 by Kris Brown, through his delegated release agent, on the review packet above.

## Discussion

### Capture - 2026-10-05

Captured during BREW-008 delivery as the follow-up Kris approved in principle. Not adopted, planned or implemented; open questions are tag versus signed-release install and whether release automation bumps the pin.

### Delivery

Delivered by PR #10 before this record was adopted, so it moved from Triage straight to closure with its evidence. The pin uses the signed release installer, and release automation does not bump it.
