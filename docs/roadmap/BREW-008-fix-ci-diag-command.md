---
id: BREW-008
title: Fix CI diag command
theme: formula-coverage
horizon: now
status: ready
blocks: [BREW-007]
blocked_by: []
baseline_ref: null
created_at: 2026-10-05T08:30:00Z
updated_at: 2026-10-05T08:30:00Z
---

## Goal

Return the tap's `CI` workflow to green on `main` so its governance and Homebrew formula gates can become required checks.

## Context

Every push to `main` since 2026-10-04 fails the KI governance step: `.github/workflows/ci.yml` still calls `ki manage diag`, and `tools-ki` main retired the `manage` command group - `diag` is now a root command and needs `--full` to report the executable path CI asserts. KI Website hit the same break and fixed it in `6e5aabf` (`fix(ci): use root ki diag command`). Until CI is green, [BREW-007](BREW-007-automate-verified-formula-updates.md) cannot make these checks required.

## Boundary

Change only the diagnostic command invocation in `ci.yml`; keep every asserted string and the bootstrap, registry and repair sequence unchanged. Do not weaken or remove an assertion, change branch rules, or alter the release-intake or dispatch workflows.

## Current state

`.github/workflows/ci.yml` lines 47, 48 and 52 run `ki manage diag | grep -F ...` for `Installation: local`, `Executable: $RUNNER_TEMP/tools-ki-source/src/main.ts` and `Status: valid`. Locally, `ki diag --full` prints all three lines. Latest `CI` run on `main` (`37269248589`) failed.

## Steps

- [ ] Take `baseline_ref`.
- [ ] Mirror KI Website `6e5aabf`: replace the two pre-bootstrap calls with one `ki diag --full | tee "$RUNNER_TEMP/ki-diag-before-bootstrap.txt"` followed by the two existing `grep -F` assertions on that file, and the post-repair call with `ki diag --full | tee "$RUNNER_TEMP/ki-diag.txt"` followed by the `Status: valid` assertion.
- [ ] Confirm locally that `ki diag --full` prints the three asserted line shapes.
- [ ] Commit, pull with rebase and push; confirm the next `CI` run on `main` succeeds.

## Files touched

- `.github/workflows/ci.yml`
- This roadmap record

## Verify

```sh
ki diag --full | grep -E 'Installation: local|Executable: |Status: valid'
grep -n 'ki manage' .github/workflows/ci.yml   # no matches
ruby test/tool_release_events_test.rb && ruby test/propose_tool_release_test.rb
ki repo audit --progress never
gh run list -R knowledgeislands/homebrew-tap --workflow CI -L 1   # success on the pushed commit
```

## Dependencies / blocks

Blocks [BREW-007](BREW-007-automate-verified-formula-updates.md): its required-check ruleset needs a green `CI` on `main` first. Blocked by nothing.

## Documentation impact

### Decision Records

None.

### Specifications

None.

### Guides

None.

### Roadmap

None beyond this record.

## Discussion

### Capture - 2026-10-05

Captured during the make-ready pass after the Fable reviewer's triage found `main` CI failing on the retired `ki manage diag` command. Adopted directly to `now` and made Ready by the Fable reviewer under delegated autonomy, reversible: the fix is a tap-owned workflow change with a proven sibling precedent.
