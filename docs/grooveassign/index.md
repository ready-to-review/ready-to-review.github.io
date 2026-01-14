# grooveASSIGN

The right reviewer, every time.

## The Problem

- **Wrong reviewers**: CODEOWNERS assigns based on paths, not who actually wrote the code
- **Manual assignment**: Tech leads waste hours triaging PRs
- **Overloaded seniors**: Same people get everything, become bottlenecks

## The Solution

grooveASSIGN automatically assigns developers who actually know the code. Line-level blame analysis, not just file history.

[Install Free](https://github.com/apps/grooveassign){ .md-button .md-button--primary }

Installs in 30 seconds. Works across your entire org.

## How It Works

1. PR is opened
2. We run `git blame` on changed lines to find who wrote them
3. Score candidates by code ownership, recent activity, and current workload
4. Apply timing boost based on when reviewers are typically active
5. Assign top reviewers (excludes bots, author, overloaded devs)

### Timing Boost

grooveASSIGN analyzes historical activity patterns to prefer reviewers who are likely available now:

| Availability | Score Adjustment |
|--------------|------------------|
| Active this hour | +30% |
| Active next hour | +20% |
| Active in 2 hours | +10% |
| Not active in 3+ hours | -25% |

This reduces review latency by assigning reviewers in their working hours, not while they're asleep.

## Pricing

| Plan | Price | Features |
|------|-------|----------|
| **Free** | $0/forever | Public repos, all features |
| **Team** | $1/user/month | Private repos |

[Get Team](https://github.com/marketplace/grooveassign){ .md-button }

## Docs

- [Getting Started](getting-started.md)
- [Configuration](configuration.md)

Questions? [honk@codegroove.dev](mailto:honk@codegroove.dev)
