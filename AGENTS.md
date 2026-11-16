# AGENTS.md — homebrew-tap

This repository packages Knowledge Islands command-line tools for Homebrew. Tool source and product behaviour stay in each upstream `tools-*` repository; this tap owns formula metadata, release URLs, checksums, installation declarations, and the post-validation website release dispatch.

## Working here

- Keep one root formula per packaged tool and derive versions from immutable upstream release artifacts.
- Do not modify tool source or choose a release independently of its upstream repository.
- Keep formula URLs, tags, versions, and SHA-256 values aligned. On a new upstream release, bump `url` to the new `vX.Y.Z` tarball and update `sha256` (`curl -fsSL <tarball> | shasum -a 256`).
- The tap has no `package.json` and no TypeScript: its content is Ruby formulae, their scripts and tests, and a README.
- Run the release-event test suite after changing its extractor or workflow.
- Use `ki-authoring` for Markdown and TOML conventions, `ki-git` for shared-tree commits, and `ki-repo-homebrew-tap` for tap-specific structure.

## Release dispatch

After a formula-changing push to `main` passes governance, CI extracts the exact source repository and tag from every changed `tools-*` formula and dispatches a `tool-release-published` event to every repository listed in [`.github/tool-release-consumers.json`](./.github/tool-release-consumers.json). The event is verified release evidence, not release authority; each consumer owns its response and any further validation or review boundary.

Configure the `KI_TOOLS_RELEASE_BOT_APP_ID` repository variable and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` Actions secret for the shared GitHub App. Install the app only on this tap, which proposes formula pull requests through it, and on listed consumers with Contents write permission for repository dispatch; grant additional permissions only when a consumer's own response requires them, such as Pull requests write for KI Website. Adding a consumer therefore requires both a reviewed registry change and a compatible receiver in that repository; CI never discovers recipients from organization membership. To retry a transient delivery failure without changing a formula, manually run the CI workflow with the exact formula name, such as `ki`. The [release App operations guide](docs/guides/maintainer/release-app-operations.md) covers credential checks, consumer onboarding and removal, replay, failure diagnosis and key-exposure response.

## Verification

```sh
ruby test/tool_release_events_test.rb
ruby test/propose_tool_release_test.rb
ruby -c scripts/tool-release-events.rb
ruby -c scripts/propose-tool-release.rb
ki repo audit --repo .
```

For a changed formula, also run Homebrew's `brew style`, `brew audit --strict --online`, `brew install --build-from-source`, and `brew test` checks for that formula.
