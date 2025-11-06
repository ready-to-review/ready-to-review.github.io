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

**[GitHub Bot](github-bot.md)** (required): Assigns reviewers based on code ownership and workload. Installed via GitHub App. [Learn more →](github-bot.md)

**[Dashboard](dashboard.md)**: View all PRs at `<org>.ready-to-review.dev`. Login with GitHub. [Learn more →](dashboard.md)

**[Slack](slack.md)**: Channel updates and DMs. Install from Slack app directory. [Learn more →](slack.md)

**[Goose](goose.md)**: Desktop notifications (macOS, Linux, Windows, BSD). Build from source. [Learn more →](goose.md)

Choose what you need. GitHub Bot + Dashboard is sufficient for most teams.

## Installation

[Getting Started](getting-started.md) - 5 minutes, three steps

## Additional Resources

- **[Plans](plans.md)** - Pricing and features for Free, Pro, and Enterprise tiers
- **[Security](security.md)** - Security architecture, data handling, and compliance
- **[Troubleshooting](troubleshooting.md)** - Common issues and solutions

## Support

Problems? [Open an issue](https://github.com/codeGROOVE-dev/support)

Design partners wanted: [Schedule a call](https://calendar.app.google/TbQmeX8iWnvx6Ci89)
