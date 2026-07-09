# CLAUDE.md — homebrew-tap

Guidance for Claude Code working in this repo. The user-facing install surface is in [README.md](./README.md); this file covers governance and the formula-maintenance workflow.

## What this repo is

The Knowledge Islands **Homebrew tap** — the distribution repo holding `Formula/*.rb`, one formula per KI command-line tool. `brew install knowledgeislands/tap/<formula>` resolves to this repo. There is **no `package.json` and no TypeScript**; the content is Ruby formulae plus a README.

The repo name (`homebrew-tap`) is **fixed by Homebrew**: `brew tap knowledgeislands/tap` expects the repo `knowledgeislands/homebrew-tap`. Do not rename it.

## Governance

Governed by the **`ki-homebrew-tap`** repo-structure skill (in the [ki-agentic-harness](https://github.com/knowledgeislands/ki-agentic-harness)), which wraps Homebrew's own formula standard. It declares `[ki-repo]` + `[ki-homebrew-tap]` in [.ki-config.toml](./.ki-config.toml). It has no `package.json`, so it is audited **from the harness**, not self-governing:

```sh
# from the ki-agentic-harness checkout
bun skills/ki-homebrew-tap/scripts/audit-homebrew-tap.ts ../homebrew-tap
```

The checker delegates to `brew audit --strict` / `brew style` when `brew` is on PATH.

## Adding or updating a formula

- One `Formula/<tool>.rb` per tool: `class <Tool> < Formula` with `desc` (≤ 80 chars, not starting with "A"/"An"/"The"), `homepage`, `url` (a **versioned release tarball**, never a branch), `sha256`, `license`, an `install` method, and a `test do` block that exercises the installed binary.
- On a new upstream release: bump `url` to the new `vX.Y.Z` tarball and update `sha256` (`curl -fsSL <tarball> | shasum -a 256`).
- Add the formula to the formulae table in [README.md](./README.md).
- Validate: `brew audit --strict --online <formula>` and `brew style <formula>` clean; `brew install --build-from-source <formula>` then `brew test <formula>`.

The source repo for each tool (e.g. [tools-mgit](https://github.com/knowledgeislands/tools-mgit)) is governed separately by `ki-tools`.
