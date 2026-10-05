---
id: BREW-009
title: Pin tools-ki checkout
theme: formula-coverage
horizon: triage
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-10-05T09:57:00Z
updated_at: 2026-10-05T09:57:00Z
---

## Goal

Make the tap's `CI` governance job install `ki` from a tools-ki release tag rather than the moving `main` branch, so upstream CLI changes cannot break the tap without a deliberate bump.

## Context

`.github/workflows/ci.yml` clones `knowledgeislands/tools-ki` with `--branch main` and links it from source. On 2026-10-04 tools-ki retired `ki manage diag`, turning every tap `CI` run red until [BREW-008](BREW-008-fix-ci-diag-command.md) removed the calls. Kris has been told this pin is planned.

## Boundary

Change only how the governance job selects the tools-ki revision (a pinned release tag, or a verified release install) and how that pin is bumped. Do not alter formula gates, consumer dispatch, GitHub settings or `propose-tool-releases.yml`. The bump mechanism may interact with [BREW-007](BREW-007-automate-verified-formula-updates.md) release triggering, which Kris is still deciding.

## Discussion

### Capture - 2026-10-05

Captured during BREW-008 delivery as the follow-up Kris approved in principle. Not adopted, planned or implemented; open questions are tag versus signed-release install and whether release automation bumps the pin.
