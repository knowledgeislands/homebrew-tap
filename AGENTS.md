# AGENTS.md — homebrew-tap

This repository packages Knowledge Islands command-line tools for Homebrew. Tool source and product behaviour stay in each upstream `tools-*` repository; this tap owns formula metadata, release URLs, checksums, installation declarations, and the post-validation website release dispatch.

## Working here

- Keep one root formula per packaged tool and derive versions from immutable upstream release artifacts.
- Do not modify tool source or choose a release independently of its upstream repository.
- Keep formula URLs, tags, versions, and SHA-256 values aligned.
- Run the release-event test suite after changing its extractor or workflow.
- Use `ki-authoring` for Markdown and TOML conventions, `ki-git` for shared-tree commits, and `ki-repo-homebrew-tap` for tap-specific structure.

## Verification

```sh
ruby test/tool_release_events_test.rb
ruby -c scripts/tool-release-events.rb
ki repo audit --repo .
```

For a changed formula, also run Homebrew's `brew style`, `brew audit --strict --online`, `brew install --build-from-source`, and `brew test` checks for that formula.
