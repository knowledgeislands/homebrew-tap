---
id: BREW-004
title: Fan out tool releases
theme: formula-coverage
horizon: now
status: done
blocks: []
blocked_by: []
baseline_ref: ee39d7831af8c7f114933a636b534f7e52ab9f53
created_at: 2026-09-19T17:39:47Z
updated_at: 2026-09-20T07:05:21Z
---

# Fan Out Tool Releases

## Goal

Every validated `tools-*` formula release should notify all explicitly configured Knowledge Islands consumers through one provider-neutral release bot.

## Context

The tap already extracts immutable release evidence after governance passes, but its workflow, script, tests, credentials, and documentation are hard-coded to KI Website. The tap is the final ordinary release channel and is therefore the right place to fan verified evidence out to the website, catalogues, documentation, or future consumers.

## Boundary

This item does not make the tap release authority, discover consumers dynamically, install skills, configure live GitHub App credentials, or define consumer-specific mutations. It does not accept non-`tools-*` source repositories.

## Current state

One `notify-website` job dispatches to `knowledgeislands/ki-website` with a token restricted to that repository. There is no committed consumer registry or generic fan-out validation.

## Steps

- [x] Replace website-named release extraction with a generic `tools-*` release-event module and focused tests.
- [x] Add a committed, validated opt-in consumer registry and dispatch every verified formula release to every configured consumer.
- [x] Rename workflow jobs and credentials around the shared tools release bot, update operator guidance, and run repository gates.

## Files touched

- `.github/tool-release-consumers.json`
- `.github/workflows/ci.yml`
- `scripts/tool-release-events.rb`
- `test/tool_release_events_test.rb`
- `CLAUDE.md`
- `docs/roadmap/_ISSUES.md`
- `docs/roadmap/BREW-004-fan-out-tool-releases.md`
- removed website-specific extractor and test paths

## Verify

```sh
ruby test/tool_release_events_test.rb
mise x actionlint@1.7.12 -- actionlint .github/workflows/ci.yml
ki repo audit --repo .
ki repo audit --skill ki-work-roadmap --repo .
```

Also run the release extractor against every committed formula and the consumer loader against the committed registry.

## Dependencies / blocks

Consumers must implement the `tool-release-published` receiver they opt into. GitHub App installation scope and repository settings remain operational prerequisites; the workflow must fail closed if they are absent.

## Documentation impact

### Decision Records

No new decision record is required; the tap remains evidence-producing distribution infrastructure and consumers retain mutation authority.

### Specifications

No portable product specification changes are required. The event envelope and opt-in registry are repository operations.

### Guides

Update tap maintenance guidance with registry ownership, shared credential names, installation scope, and retry behaviour.

### Roadmap

Coordinate with website item `KI-WEB-SITE-013`; future consumers opt in through their own reviewed receiver work and a tap registry change.

## Review

### Delivered

Delivered the approved fan-out boundary from baseline `ee39d7831af8c7f114933a636b534f7e52ab9f53`, with implementation evidence at `d83e2fb02c9ac44fe56c6e081cda70f9c0edc97d`. The tap now accepts only `knowledgeislands/tools-*` release URLs, resolves a committed consumer registry, and sends the same bounded evidence event to every configured repository.

### Change Summary

Replaced the website-specific extractor and tests with `scripts/tool-release-events.rb` and its 11-test suite; added `.github/tool-release-consumers.json`; generalized the CI job, token scope, credential names, summaries, and nested fan-out; documented opt-in and permission boundaries in `CLAUDE.md`.

### Verification

`ruby test/tool_release_events_test.rb` passed 11 tests and 31 assertions. Every committed formula produced a valid event, and the committed registry resolved `knowledgeislands/ki-website`. Actionlint 1.7.12 passed. Focused `ki-authoring` and `ki-work-roadmap` audits passed. Homebrew tap PR #2 `KI governance` passed in a normal GitHub checkout; its notification job was correctly skipped for a pull request.

### Outstanding concerns

Live dispatch remains intentionally unavailable until the shared GitHub App is installed on each listed consumer and `KI_TOOLS_RELEASE_BOT_APP_ID` plus `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` are configured in repository settings. No credential is committed or weakened to bypass that stop.

### Post-change review

The registry is explicit, sorted, unique, organization-scoped, and fail-closed. Formula parsing rejects non-`tools-*` repositories and conflicting release identities. The workflow mints one token restricted to the configured consumers and gives consumers evidence only; it does not grant cross-repository mutation authority.

### Mini recap

The Homebrew tap now provides a generic release-event fan-out for every packaged Knowledge Islands tool, with KI Website as the first consumer. Local focused gates and hosted governance CI pass; operational App provisioning remains the only live cutover step.

## Done

Accepted 2026-09-20 by Kris Brown on the review packet above, with authority to complete the operational cutover and prune the retained record after this closure lands.

## Discussion

### Explicit consumers

A committed registry keeps fan-out reviewable and fail-closed. Repository names are validated under the `knowledgeislands` organization; the bot never scans the organization or infers recipients.

### Consumer autonomy

The bot delivers evidence only. Each consumer decides whether to ignore it, validate it, open a pull request, or take another action within its own repository authority.

### One application identity

One narrowly installed GitHub App can mint a token for the configured consumer set. Its repository installations and permissions remain explicit operational controls outside Git.
