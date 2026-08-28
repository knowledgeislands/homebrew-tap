# knowledgeislands/homebrew-tap

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

Homebrew formulae for Knowledge Islands command-line tools.

This repository is a [Homebrew tap](https://docs.brew.sh/Taps): a distribution channel holding one `Formula/<tool>.rb` per [Knowledge Islands](https://github.com/knowledgeislands) command-line tool. Homebrew resolves the tap name `knowledgeislands/tap` to the repository `knowledgeislands/homebrew-tap`, which is why the repository name carries the `homebrew-` prefix and the tap name does not. Each tool is developed in its own `tools-*` repository; only its packaging lives here.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Formulae](#formulae)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

Knowledge Islands tools are released as tagged tarballs from their own repositories. A tap gives those releases a single, versioned install surface on macOS and Linux, so a tool can be installed and upgraded with the same commands as anything else in Homebrew, without a curl-to-shell installer or a manual download step. The tap holds no tool source — a formula points at an upstream release tarball and its `sha256`, and is bumped when that tool cuts a release.

## Install

```sh
brew install knowledgeislands/tap/<formula>
```

Naming the tap in the install argument taps it implicitly, so a separate `brew tap knowledgeislands/tap` is not needed.

### Dependencies

[Homebrew](https://brew.sh) on macOS or Linux. Individual formulae declare any further dependencies themselves; Homebrew installs them.

### Updating

```sh
brew update
brew upgrade knowledgeislands/tap/<formula>
```

## Usage

Install a formula, then run its command. Each tool documents itself:

```sh
brew install knowledgeislands/tap/mgit
mgit --help
man mgit
```

Full command documentation lives with each tool, in the source repository linked from the table below.

## Formulae

| Formula | Description | Source |
| --- | --- | --- |
| `ki` | Knowledge Islands command-line interface. | [tools-ki](https://github.com/knowledgeislands/tools-ki) |
| `mgit` | Run commands across many git repositories at once. | [tools-mgit](https://github.com/knowledgeislands/tools-mgit) |

## Maintainers

[@krisb](https://github.com/krisb).

## Contributing

Packaging issues — a formula that fails to install, a stale version, a missing platform — belong in [this repository's issues](https://github.com/knowledgeislands/homebrew-tap/issues). Bugs and feature requests for a tool itself belong in that tool's own repository, linked from the table above.

PRs are welcome. A formula change should keep `brew audit --strict --online <formula>` and `brew style <formula>` clean, and `brew test <formula>` passing after `brew install --build-from-source <formula>`; [CLAUDE.md](./CLAUDE.md) records the full maintenance workflow.

## License

[MIT](./LICENSE) © 2026 Kris Brown.
