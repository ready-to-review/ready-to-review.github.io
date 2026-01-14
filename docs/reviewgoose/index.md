# reviewGOOSE

PRs that merge in minutes, not days.

## The Problem

Industry average PR merge time is 4.5 days. Most of that is waiting - unclear whose turn it is, missed notifications, context switching.

## The Solution

reviewGOOSE tracks whose turn it is and notifies the right person at the right time.

[Get Started](getting-started.md){ .md-button .md-button--primary }

## How It Works

1. GitHub App monitors your PRs
2. We determine who needs to act: fix tests, review, address feedback, merge
3. Notify via Slack DM, channel post, or desktop app
4. Dashboard shows all PRs organized by "waiting on you" vs "waiting on others"

## Components

- **[GitHub](github-bot.md)**: Connects to your repos, sends events
- **[Web](dashboard.md)**: Dashboard at `<org>.reviewgoose.dev`
- **[Slack](slack.md)**: Channel posts and DMs
- **[Desktop](goose.md)**: Native notifications

## Pricing

Free for public repos. [Plans](plans.md) for private repos.

## Docs

- [Getting Started](getting-started.md)
- [Troubleshooting](troubleshooting.md)
- [Security](security.md)

Questions? [Get Support](https://codegroove.dev/support)
