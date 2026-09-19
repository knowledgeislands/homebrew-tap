---
id: BREW-003
title: Dispatch website release
theme: formula-coverage
horizon: now
status: done
blocks: []
blocked_by: []
baseline_ref: a0b9ede635472e46c13b0265d3ee64b5dad49d0f
created_at: 2026-09-19T09:26:42Z
updated_at: 2026-09-19T10:01:14Z
---

# Dispatch Website Release

## Goal

A successfully validated Homebrew formula update should notify the KI Website of the exact tool release so the website can prepare its own reviewable registry update.

## Context

Tool releases are published by their source repositories, then packaged by this tap. The website currently depends on a manual handoff after those steps, which allowed its `ki` registry entry to remain at v0.3.6 after the v0.4.0 formula became available. The approved flow uses successful tap CI as the final event trigger while preserving source-repository and website authority.

## Boundary

This repository will not edit the website, create a website pull request, select a version independently of formula content, or dispatch from pull-request and failed-CI runs. Credentials remain GitHub repository settings and are never committed.

## Current state

The tap validates repository governance on pushes and pull requests. It has no post-validation release-event extractor or cross-repository notification.

## Steps

- [x] Extract changed formula release identities deterministically from a validated main-branch push, with a manual exact-formula retry path.
- [x] Test duplicate URLs, malformed formulae, non-release URLs, and valid multi-platform formulae.
- [x] Dispatch one bounded `tool-release-published` payload per changed formula only after governance succeeds.
- [x] Authenticate with a narrowly installed GitHub App and fail closed when release identity cannot be proven.
- [x] Document setup and retry behaviour, then run tests and repository audits.

## Files touched

- `.github/workflows/ci.yml`
- `scripts/website-release-events.rb`
- `test/website_release_events_test.rb`
- `CLAUDE.md`
- `docs/roadmap/_ISSUES.md`
- `docs/roadmap/BREW-003-dispatch-website-release.md`

## Verify

```sh
ruby test/website_release_events_test.rb
ki repo audit --repo .
ki repo audit --skill ki-work-roadmap --repo .
```

Also run the extractor against `Formula/ki.rb` and validate its emitted repository, tag, formula, and source path.

## Dependencies / blocks

The website receiver must merge before this dispatcher is enabled. Live dispatch requires a GitHub App installed on `knowledgeislands/ki-website`; this repository stores only its App ID and private-key secret. This sequencing is operational rather than a local roadmap dependency.

## Documentation impact

### Decision Records

No new Decision Record is required because the source tool, tap, and website ownership boundaries remain unchanged.

### Specifications

No portable behaviour specification changes; this is release-channel coordination.

### Guides

Extend the repository maintenance guidance with the post-CI website notification and manual retry contract.

### Roadmap

Coordinate with `KI-WEB-SITE-012`; no further tap work is expected after the receiver and dispatcher are proven.

## Review

### Delivered

Delivered the approved dispatcher boundary from baseline `a0b9ede635472e46c13b0265d3ee64b5dad49d0f`, with implementation evidence at `b028d4139025c5fcef91b585c1438c8c9fbddc7e`. After successful governance on a `main` formula change, the tap extracts exact release evidence and dispatches one bounded website event; manual retry remains exact-formula only, and the tap neither edits the website nor selects a release independently.

### Summary of changes

Added `scripts/website-release-events.rb` and its Minitest suite, extended `.github/workflows/ci.yml` with post-governance dispatch and manual retry, and documented GitHub App configuration and retry behaviour in `CLAUDE.md`. The workflow mints a token restricted to `ki-website` and stops on unsupported, missing, or inconsistent formula release URLs.

### Verification

`ruby test/website_release_events_test.rb` passed 5 tests and 12 assertions; pinned Actionlint 1.7.12 passed the changed workflow; the extractor produced the expected `knowledgeislands/tools-ki` v0.4.0 payload for `Formula/ki.rb`; and the focused roadmap audit passed. A whole-repository audit from the temporary worktree reported only runtime-activation and local-registry findings caused by the temporary physical root rather than repository content.

### Outstanding concerns

The GitHub App variable, private-key secret, installation permissions, and first live cross-repository dispatch cannot be proven locally. Their absence fails the notification job closed and remains an operational setup step documented in `CLAUDE.md`.

### Post-change review

The implementation stays within the approved post-governance, changed-formula, evidence-only event boundary. Tests cover multi-platform duplication, tag archives, missing and unsupported URLs, and inconsistent versions; the explicit manual retry validates one existing formula. The item is ready for acceptance subject to the stated live-credential concern.

### Mini recap

The Homebrew tap now has a tested dispatcher for verified formula releases, coordinated with the already integrated KI Website receiver. Verification is clean apart from environment-only findings in the temporary worktree; no additional durable learning route is required beyond the updated maintenance guidance.

## Done

Accepted 2026-09-19 by Kris Brown on the review packet above.

## Discussion

### Why the tap triggers

The tap is the last ordinary release channel to validate a version. Triggering here means the website review begins only after both the immutable source release and package-manager formula exist.

### Why authority stays upstream

The event carries the formula's evidence but cannot redefine the released version. The website independently checks the source repository release and the formula at the named tap commit before proposing publication.

### Retry model

A manual exact-formula dispatch reuses the same extractor and payload after a transient delivery failure. Re-running the receiver is idempotent because it targets one deterministic version branch and no-ops when the registry already matches.
