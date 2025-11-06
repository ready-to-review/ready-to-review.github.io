# Ready-to-Review

Automated PR tracking that eliminates coordination overhead. PRs merge in under an hour instead of 4.5 days.

## How It Works

Every PR has exactly one responsible party at any moment:

- **Author's turn**: Fix CI, address feedback, resolve conflicts
- **Reviewer's turn**: Review or re-review
- **Waiting**: CI running or approved

State changes trigger notifications. Turn-based clarity replaces ambiguity.

Architecture: https://github.com/codeGROOVE-dev/architecture/blob/main/README.md

## Components

**GitHub Bot** (required): Assigns reviewers based on code ownership and workload. Installed via GitHub App.

**Dashboard**: View all PRs at `<org>.ready-to-review.dev`. Login with GitHub.

**Slack**: Channel updates and DMs. Install from Slack app directory.

**Goose**: Desktop notifications (macOS, Linux, Windows, BSD). Build from source.

Choose what you need. GitHub Bot + Dashboard is sufficient for most teams.

## Installation

[Getting Started](getting-started.md) - 5 minutes, three steps

## Support

Problems? https://github.com/codeGROOVE-dev/support

Design partners wanted: https://calendar.app.google/TbQmeX8iWnvx6Ci89
