---
id: BREW-008
title: Fix CI diag command
theme: formula-coverage
horizon: now
status: in-progress
blocks: [BREW-007]
blocked_by: []
baseline_ref: 2949c1eaa2f3f82c39315502c8ebf4c4d505508a
created_at: 2026-10-05T08:30:00Z
updated_at: 2026-10-05T09:57:00Z
---

## Goal

Return the tap's `CI` workflow to green on `main` so its governance and Homebrew formula gates can become required checks.

## Context

Every push to `main` since 2026-10-04 fails the KI governance step: `.github/workflows/ci.yml` still calls `ki manage diag`, and `tools-ki` main retired the `manage` command group - `diag` is now a root command and needs `--full` to report the executable path CI asserts. KI Website hit the same break and fixed it in `6e5aabf` (`fix(ci): use root ki diag command`). Until CI is green, [BREW-007](BREW-007-automate-verified-formula-updates.md) cannot make these checks required.

## Boundary

Remove only the three `ki manage diag | grep -F` assertions from the `Link latest KI from main` step of `ci.yml`. Keep `test "$(command -v ki)" = "$KI_CLI_INSTALL_DIR/ki"` and `ki --version` as the proof that CI runs the source-linked `ki`, and keep the bootstrap, registry, repair and harness sequence unchanged. Do not change branch rules, GitHub settings, the release-intake or dispatch workflows, or the tools-ki checkout ref (pinning it is [BREW-009](BREW-009-pin-tools-ki-checkout.md)).

Owner decision (Kris, 2026-10-05): the diag assertions only confirmed that the from-source install worked, which `command -v` and `ki --version` already prove, so they are redundant. This supersedes the earlier plan to mirror KI Website `6e5aabf` with `ki diag --full`.

## Current state

`.github/workflows/ci.yml` lines 47, 48 and 52 run `ki manage diag | grep -F ...` for `Installation: local`, `Executable: $RUNNER_TEMP/tools-ki-source/src/main.ts` and `Status: valid`. Locally, `ki diag --full` prints all three lines. Latest `CI` run on `main` (`37282689073`) failed at that step.

## Steps

- [x] Take `baseline_ref`.
- [x] Delete the three `ki manage diag | grep -F` lines; keep the `command -v` test and `ki --version`.
- [x] Confirm the workflow parses as YAML and no `ki manage` call remains.
- [ ] Commit, pull with rebase and push; confirm the next `CI` run on `main` succeeds.

## Files touched

- `.github/workflows/ci.yml`
- This roadmap record

## Verify

```sh
ruby -ryaml -e 'YAML.load_file(".github/workflows/ci.yml")'
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

## Review

### Delivered

Within the owner-revised boundary: the three redundant `ki manage diag` assertions are gone from the governance step; the source-link proof (`command -v` against `$KI_CLI_INSTALL_DIR/ki`, then `ki --version`) and the bootstrap, registry, repair and harness sequence are unchanged. Excluded: the tools-ki release-tag pin (captured as BREW-009), GitHub settings and `propose-tool-releases.yml`. Baseline `2949c1eaa2f3f82c39315502c8ebf4c4d505508a`.

### Change Summary

- `.github/workflows/ci.yml`: three lines removed (previous lines 47, 48 and 52).
- This record: boundary, steps and verification revised to Kris's 2026-10-05 decision; review packet added.
- `docs/roadmap/BREW-009-pin-tools-ki-checkout.md` and `_ISSUES.md`: Triage capture of the planned pin follow-up.

### Verification

- `ruby -ryaml -e 'YAML.load_file(".github/workflows/ci.yml")'`: parses.
- `grep -n 'ki manage' .github/workflows/ci.yml`: no matches.
- `ruby test/tool_release_events_test.rb`: 11 runs, 0 failures; `ruby test/propose_tool_release_test.rb`: 7 runs, 0 failures.
- `ki repo audit --progress never`: see the Mini recap for the result at commit time.
- `CI` on `main` after push: recorded by the delivery report; acceptance should confirm it is green.

### Outstanding concerns

CI still clones tools-ki `main`, so a future breaking change there can turn the tap red again; BREW-009 owns pinning. `actionlint` is not installed locally, so workflow linting relied on YAML parsing and CI itself.

### Post-change review

The goal (green `CI` on `main` so BREW-007 can later make it required) is met by removing the only failing commands; the remaining checks still prove CI runs the source-linked `ki`. Regression risk is minimal: the change only deletes assertions that duplicated existing proof. Ready for acceptance once the post-push `CI` run is confirmed green.

### Mini recap

Delivered the owner-directed removal of the retired `ki manage diag` assertions and captured the tools-ki pin as Triage BREW-009. Local YAML, grep and Ruby test gates pass. Learning route: none beyond BREW-009.

## Discussion

### Capture - 2026-10-05

Captured during the make-ready pass after the Fable reviewer's triage found `main` CI failing on the retired `ki manage diag` command. Adopted directly to `now` and made Ready by the Fable reviewer under delegated autonomy, reversible: the fix is a tap-owned workflow change with a proven sibling precedent.

### Owner decision - 2026-10-05

Kris decided the `ki manage diag` assertions are redundant with the existing `command -v` test and `ki --version`, so they are dropped rather than migrated to `ki diag --full`. Pinning the tools-ki checkout to a release tag is planned and captured separately as BREW-009.
