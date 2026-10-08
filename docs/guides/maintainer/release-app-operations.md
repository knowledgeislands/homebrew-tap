# Release App operations

Use this guide to operate the sender side of the tool release chain: the shared `ki-tools-release-bot` GitHub App as this tap uses it to receive tool releases, propose formula updates and notify release consumers. App administration and every credential step are reserved for the organisation owner.

The `knowledgeislands` organisation owns the App. Arcadia's GitHub Apps convention, in `ki-arcadia-principal` at `Admin/Governance/Conventions/Admin Conventions/GitHub Apps.md`, records its permissions, installation targets, credential holders, key custody and the key rotation procedure. This guide cites that procedure rather than repeating it. Each consumer owns its receiver, its validation and its review boundary; the decision to auto-merge KI Website updates is recorded in `ki-website` as ODR-KI-WEBSITE-001.

## The chain

1. A `tools-*` release workflow mints an App token scoped to `homebrew-tap` and sends a `tool-release-published` repository dispatch carrying the source repository and tag.
2. [`propose-tool-releases.yml`](../../../.github/workflows/propose-tool-releases.yml) validates the dispatch, checks each formula's source repository for a newer immutable release, and pushes an `automation/formula-<tool>-<version>` branch with a pull request set to squash auto-merge. Its daily schedule backstops a missed dispatch.
3. The formula pull request merges only after the required `KI governance` and `Homebrew formula gates` checks pass.
4. On the push to `main`, the `Notify release consumers` job in [`ci.yml`](../../../.github/workflows/ci.yml) extracts the exact source repository and tag from each changed formula, mints a token scoped to the repositories in [`.github/tool-release-consumers.json`](../../../.github/tool-release-consumers.json), and dispatches `tool-release-published` with the tap commit to each one.
5. Each consumer's receiver verifies the event and acts within its own boundary. KI Website opens a registry pull request and requests auto-merge.

The App is therefore installed on the tap itself, for step 2, and on every registered consumer, for step 4. A repository listed in the registry without an installation fails the token mint; an installation without a registry entry never receives an event.

## Confirm the credentials without reading them

The tap, every consumer that mints its own token and every tool repository that dispatches to the tap hold the repository variable `KI_TOOLS_RELEASE_BOT_APP_ID` and the Actions secret `KI_TOOLS_RELEASE_BOT_PRIVATE_KEY`. GitHub never returns a secret's value, only its name and update time, so listing them proves presence without exposure:

```sh
gh variable list --repo knowledgeislands/homebrew-tap
gh secret list --repo knowledgeislands/homebrew-tap
```

Repeat for each holder named in the Arcadia convention. A missing variable makes a tool repository skip its dispatch silently, because its notify job runs only when the variable is set; the tap's daily schedule then picks the release up instead. After a rotation, every holder's secret should show the same update day.

Never print, copy or commit the private key, and never record it in an issue, workflow output, chat or email.

## Onboard a consumer

1. The consumer adds a fail-closed receiver for `tool-release-published`. It must verify the immutable source release and the tap evidence before writing, and keep its normal review and deployment boundary.
2. Review the minimum App permissions the receiver needs. Widen the App's permissions only when the consumer cannot work within the existing ones, and record the change in the Arcadia convention.
3. With the consumer owner's consent, add that one repository to the App's selected installation. Do not switch the installation to all repositories.
4. If the receiver mints its own App token, set the variable and secret in the consumer through the Arcadia procedure.
5. Add the repository to `.github/tool-release-consumers.json` in a reviewed change. The release-event tests validate the registry.
6. Replay one already-published release, as in [Retry and replay](#retry-and-replay), and confirm both the tap dispatch and the receiver's bounded outcome.

## Remove a consumer

1. Remove the repository from `.github/tool-release-consumers.json` in a reviewed change, so the next dispatch no longer scopes a token to it.
2. Remove the repository from the App's selected installation.
3. Delete the consumer's App variable and secret when no other workflow there uses them, and update the credential holders in the Arcadia convention.
4. Ask the consumer owner to retire or disable its receiver.

## Retry and replay

A formula-changing push to `main` dispatches automatically. To resend a release to every registered consumer without changing a formula, run the tap's `CI` workflow with the exact formula name:

```sh
gh workflow run CI --repo knowledgeislands/homebrew-tap -f formula=ki
```

To repeat the intake when a tool release did not produce a formula pull request, run the proposal workflow; it scans every formula, so no input is needed:

```sh
gh workflow run propose-tool-releases.yml --repo knowledgeislands/homebrew-tap
```

Replaying an already-current release is the preferred smoke test. The tap run should show successful `KI governance` and `Notify release consumers` jobs, and a correct receiver verifies the event and exits without a commit or pull request. A sent event is not a completed handoff: check the receiver's run and any pull request it opens.

## Diagnose a failure

| Symptom | Likely cause | Action |
| --- | --- | --- |
| The token step fails before any API call | Variable or secret missing or misnamed, or the secret holds an empty or retired key | Confirm the names as above; if the secret is stale or empty, reset it through the Arcadia procedure |
| The token step reports an inaccessible repository | A registered consumer, or the tap itself, is not in the App installation | Add the installation with the owner's consent, or remove the registry entry |
| A dispatch returns `404` | The target is not in the token's repositories or does not exist | Check the registry spelling and the installation |
| A dispatch returns `403` | The App lacks Contents write on the target | Review the installation's permissions against step 2 of onboarding |
| The proposal reports `latest release not immutable; skipped` | The tool's latest release is mutable | Fix the release in the tool repository; never patch the formula by hand around it |
| The proposal reports `proposal branch already exists` | An earlier proposal for the same version is still open or failed | Inspect that pull request and its checks; delete the branch only after closing it |
| A formula pull request does not merge | A required check failed | Fix the cause through the tool or formula; never bypass the checks |
| A receiver fails validation | The event or release evidence does not verify | Fix or reissue the evidence; never weaken the receiver's checks or substitute a personal access token |

## Respond to a key exposure

Treat any unexpected exposure of the private key as a compromise; do not wait for evidence of misuse.

1. Delete the exposed key from the App's settings page at once. Every release workflow fails from that moment, which is the intended containment.
2. Generate a replacement key and distribute it to every credential holder by following the rotation procedure in the Arcadia convention, including its guard against setting an empty secret.
3. Confirm each holder's secret update time as above.
4. Replay a release to a consumer and run the proposal workflow, and confirm both succeed.
5. Review the App's recent activity for actions not explained by the chain's own runs, and report the incident to the organisation owner.

A planned rotation follows the Arcadia procedure alone; it keeps the old key valid until every holder has the new one.
