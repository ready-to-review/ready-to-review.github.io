# Plans

**Part of reviewGOOSE** - [Home](index.md) | [Getting Started](getting-started.md) | [Security](security.md) | [Troubleshooting](troubleshooting.md)

All plans include all features. The only difference is repository access.

## Plan Comparison

| Feature | Free | Pro | Flock |
|---------|------|-----|-------|
| **Price** | $0 forever | $2/month | $3/seat/month |
| **Repository Access** | Public only | Public + Private | Public + Private |
| **Billing** | None | GitHub Marketplace | GitHub Marketplace (org-wide) |
| **Desktop App** | Yes | Yes | Yes |
| **Slack Integration** | Yes | Yes | Yes |
| **Turn-based Tracking** | Yes | Yes | Yes |
| **Real-time Notifications** | Yes | Yes | Yes |
| **Support** | Community | Community | Priority |

## Which Plan?

**Free** - Contributing to open source? This is for you. Works with any public repository on GitHub.

**Pro** - Work on private repos? $2/month unlocks them. Covers your employer's repos, side projects, and client work.

**Flock** - Rolling out to a team? Billed through GitHub Marketplace, add/remove seats anytime.

## Private Repository Access

**Requires**: Pro or Flock plan + reviewGOOSE:GitHub App installed

To access private repositories:

1. Subscribe to Pro ($2/mo) or Flock ($3/seat/mo)
2. Install the [reviewGOOSE:GitHub App](https://github.com/apps/reviewgoose) on your organization
3. Select private repositories during installation

**What we access**: PR metadata only (titles, authors, reviewers, status). Never source code.

**Real-time vs polling**: Real-time notifications (under 1 second) only work for repos where the GitHub App is installed. Without it, the desktop app polls GitHub API (every few minutes, rate-limited).

## Enterprise

For teams needing custom contracts (MSAs, DPAs for GDPR/CCPA, BAAs for HIPAA) or dedicated support:

[Contact Sales](mailto:flock@codegroove.dev){ .md-button }

## FAQ

### Can I use Free and Pro together?
Yes. Free covers public repos, Pro covers private. They work simultaneously.

### What if I uninstall?
Your data is deleted within 48 hours. No lock-in.

### Is there a free trial for Pro?
Use Free tier on public repos to evaluate. The experience is identical. Upgrade when you need private repos.
