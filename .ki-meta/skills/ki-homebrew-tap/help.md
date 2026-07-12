# ki-homebrew-tap

Codify, audit, and scaffold the Knowledge Islands Homebrew tap — the `homebrew-<x>` distribution repo that holds `Formula/*.rb` for Knowledge Islands command-line tools.

**Invoke:** `ki-homebrew-tap audit <repo> | conform <repo> | help | init <repo> | refresh`

**Modes:**

- `AUDIT  `
- `CONFORM`
- `HELP   ` — explain this skill and stop; the default when no mode is given (then routes, if interactive)
- `INIT   `
- `REFRESH`

**See also:** Governs the tap **container** — the repo shape and the formula shape — not the tools themselves (for a `tools-*` CLI repo use `ki-tools`) nor the repo's GitHub settings and standard files (for those use `ki-repo`).
