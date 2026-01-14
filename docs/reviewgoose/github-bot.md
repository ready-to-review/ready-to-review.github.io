# reviewGOOSE:GitHub

The GitHub App is the foundation of reviewGOOSE. It provides:

1. **Real-time notifications**: Sends PR events to Slack and Desktop instantly
2. **PR state tracking**: Monitors CI status, approvals, and changes
3. **Turn-based tracking**: Determines whose turn it is to act on each PR

**Required for all other components to function.**

**Part of reviewGOOSE** - [Home](index.md) | [Getting Started](getting-started.md) | [Dashboard](dashboard.md) | [Slack](slack.md) | [Desktop](goose.md)

## How It Works

When you create or update a PR:

1. **GitHub webhook** fires and sends event to reviewGOOSE
2. **Real-time broadcast** to Slack and Desktop (under 1 second)
3. **State tracking** updates based on CI, approvals, and changes

**Typical response time:** Under 1 second

## Installation

--8<-- "docs/.snippets/github-app-install.md"

The app will automatically:
- Enable real-time notifications for all selected repos
- Track PR state changes

To add/remove repos later: [GitHub Settings → Installed GitHub Apps](https://github.com/settings/installations) → reviewGOOSE:GitHub App → Configure → Repository access

## GitHub Permissions

Required permissions:

- Pull requests: Read (track PR state)
- Contents: Read (read `.codeGROOVE` configuration files)
- Repository metadata: Read (repo names)
- Organization members: Read (identify reviewers)

**Note:** Contents access is used only to read configuration files in your `.codeGROOVE` repository (like `slack.yaml`). We do not read source code in your other repositories.

Details: [Security](security.md)

## Troubleshooting

**PRs not appearing**: Check if GitHub App installed on repo. Verify repository access in GitHub Settings → Installed GitHub Apps. Wait 60 seconds for sync.

**Webhook failures**: Go to Repository Settings → Webhooks. Check "Recent Deliveries" for errors.

**Stale data**: Hard refresh Dashboard (Ctrl+Shift+R). Data updates within 60 seconds of GitHub events.

[Get Support →](https://github.com/codeGROOVE-dev/support/issues/new?template=support-request.md){ .md-button }
