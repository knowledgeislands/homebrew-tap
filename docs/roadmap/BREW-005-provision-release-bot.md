---
id: BREW-005
title: Provision release bot
theme: formula-coverage
horizon: triage
status: draft
blocks: []
blocked_by: []
baseline_ref: null
created_at: 2026-09-20T07:34:49Z
updated_at: 2026-09-20T07:34:49Z
---

## Goal

Activate the reviewed generic tool-release fanout with a shared GitHub App and prove one end-to-end release event reaches an explicitly configured consumer.

## Context

Homebrew Tap owns the release-event registry, dispatch workflow, and sender credentials. The implementation and hosted review gates pass, but live dispatch remains fail-closed until the App is installed for configured consumers and `KI_TOOLS_RELEASE_BOT_APP_ID` plus `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY` are configured for the tap workflow.

Each consumer repository independently owns its receiver workflow and installation consent. KI Website is the first configured consumer.

## Boundary

Do not commit credentials, broaden the App beyond listed consumers, grant merge or deployment authority, or make Homebrew Tap own consumer-side policy. Provisioning must preserve the existing bounded evidence event and each receiver's independent validation and review boundary.

## Discussion

### Operational ownership

Keep sender configuration with Homebrew Tap because formula release events originate there and its committed registry determines fanout. Treat the GitHub App as shared organisation infrastructure, while every consumer retains authority over installation and receiver behaviour.

### Completion evidence

Completion needs repository-setting evidence without secret values, one successful dispatch from a real tool release or bounded test event, and observable receipt by KI Website without automatic merge or deployment.
