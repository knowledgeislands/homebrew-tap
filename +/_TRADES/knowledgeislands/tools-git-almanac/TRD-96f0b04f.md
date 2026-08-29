---
id: TRD-96f0b04f
title: "Add git-almanac formula after v1.0.0 release"
created_at: 2026-08-26T09:44:35Z
sender: knowledgeislands/tools-git-almanac
receiver: knowledgeislands/homebrew-tap
kind: work
source_ref: "ALMANAC-CLI-002"
observation: completion
phase: received
decision_status: adopted
received_from_ref: fd7c93e4a5119d6770521a74f7994320aeca2f3c
reviewed_at: 2026-08-29T02:09:27Z
adopted_as: BREW-001
rationale: "Accepted; tracked locally as BREW-001, which waits on the upstream release the submission is conditional on."
---

# TRD-96f0b04f: Add git-almanac formula after v1.0.0 release

## Context

Git Almanac provides a Node 22 Git extension, portable release archive, SHA256SUMS, manual page, and verified installer contract. The repository is implementing ALMANAC-CLI-002 and no release has been published.

## Submission

After `knowledgeislands/tools-git-almanac` publishes immutable v1.0.0, add and verify a `git-almanac` Homebrew formula using `git-almanac-v1.0.0.tar.gz` and its published checksum.

## Constraints

Do not create the formula from a mutable branch. Pin the immutable v1.0.0 archive and checksum; depend on `node@22` or a compatible Node 22 runtime; install the `git-almanac` executable and `git-almanac.1` manual; verify `git-almanac --version`, `git almanac calendar` against a temporary repository, and the installed manual.
