# CLAUDE.md — homebrew-tap

Guidance for Claude Code working in this repo. The user-facing install surface is in [README.md](./README.md); this file covers governance and the formula-maintenance workflow.

## What this repo is

The Knowledge Islands **Homebrew tap** — the distribution repo holding `Formula/*.rb`, one formula per KI command-line tool. `brew install knowledgeislands/tap/<formula>` resolves to this repo. There is **no `package.json` and no TypeScript**; the content is Ruby formulae plus a README.

The repo name (`homebrew-tap`) is **fixed by Homebrew**: `brew tap knowledgeislands/tap` expects the repo `knowledgeislands/homebrew-tap`. Do not rename it.

## Governance

Governed by the **`ki-repo-homebrew-tap`** repo-structure skill (in the [ki-agentic-harness](https://github.com/knowledgeislands/ki-agentic-harness)), which wraps Homebrew's own formula standard. It declares `[skills.ki-repo]`, `[skills.ki-repo-project]`, and `[skills.ki-repo-homebrew-tap]` in [.ki.toml](./.ki.toml). It has no `package.json`; run the native repository audit directly:

```sh
ki repo audit --repo .
```

The checker delegates to `brew audit --strict` / `brew style` when `brew` is on PATH.

## Adding or updating a formula

- One `Formula/<tool>.rb` per tool: `class <Tool> < Formula` with `desc` (≤ 80 chars, not starting with "A"/"An"/"The"), `homepage`, `url` (a **versioned release tarball**, never a branch), `sha256`, `license`, an `install` method, and a `test do` block that exercises the installed binary.
- On a new upstream release: bump `url` to the new `vX.Y.Z` tarball and update `sha256` (`curl -fsSL <tarball> | shasum -a 256`).
- Add the formula to the formulae table in [README.md](./README.md).
- Validate: `brew audit --strict --online <formula>` and `brew style <formula>` clean; `brew install --build-from-source <formula>` then `brew test <formula>`.

After a formula-changing push to `main` passes governance, CI extracts the exact source repository and tag from every changed `tools-*` formula and dispatches a `tool-release-published` event to every repository listed in [`.github/tool-release-consumers.json`](./.github/tool-release-consumers.json). The event is verified release evidence, not release authority; each consumer owns its response and any further validation or review boundary.

Configure the `KI_TOOLS_RELEASE_BOT_APP_ID` repository variable and `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` Actions secret for the shared GitHub App. Install the app only on listed consumers with Contents write permission for repository dispatch; grant additional permissions only when a consumer's own response requires them, such as Pull requests write for KI Website. Adding a consumer therefore requires both a reviewed registry change and a compatible receiver in that repository; CI never discovers recipients from organization membership. To retry a transient delivery failure without changing a formula, manually run the CI workflow with the exact formula name, such as `ki`.

The source repo for each tool (e.g. [tools-mgit](https://github.com/knowledgeislands/tools-mgit)) is governed separately by `ki-repo-tools`.
