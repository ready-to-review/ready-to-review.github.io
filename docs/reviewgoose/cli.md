# reviewGOOSE:CLI

Command-line interface for developers who live in the terminal.

Shows which PRs are actually waiting on you. That's it.

## Install

=== "Homebrew"

    ```bash
    brew install codegroove-dev/tap/review-goose-cli
    ```

=== "Go Install"

    ```bash
    go install github.com/codeGROOVE-dev/prs@latest
    ```

=== "Build from Source"

    ```bash
    git clone https://github.com/codeGROOVE-dev/prs
    cd prs
    make build
    # Binary will be at ./out/prs
    ```

## Prerequisites

- **GitHub CLI**: Must be installed and authenticated
  ```bash
  gh auth status || gh auth login
  ```

- **Go 1.23.4+**: Required if building from source

## Quick Start

```bash
# Show all PRs you're involved with
prs

# Show only PRs blocking on you
prs --blocked

# Live monitor mode (updates every 60 seconds)
prs --watch
```

## Commands & Options

### Basic Usage

| Command | Description |
|---------|-------------|
| `prs` | Show all PRs you're involved with |
| `prs --blocked` | Show only PRs blocking on you (critical only) |
| `prs --watch` | Continuously monitor PRs with live updates |

### Filtering Options

| Flag | Description |
|------|-------------|
| `--include-stale` | Include PRs unchanged for 90+ days (normally filtered) |
| `--exclude-orgs <orgs>` | Skip specific organizations (comma-separated) |
| `--user <username>` | View PRs for a different user |
| `--no-cache` | Disable Turn API response caching |

### Debugging

| Flag | Description |
|------|-------------|
| `--verbose` | Enable verbose logging from libraries |
| `NO_COLOR=1` | Disable colored output (environment variable) |

## Output Format

The CLI displays PRs in two sections:

### Incoming PRs
PRs from others where you're involved (reviews, mentions, etc.)

### Outgoing PRs
PRs authored by you

### Color Coding

- **Red** (#E5484D): "blocked on YOU" - critical actions required
- **Orange** (#FFB224): "awaiting your input" - needs attention
- **Gray** (#8B8B8B): Outgoing PRs (your own)
- **Standard**: Other incoming PRs

## Examples

### Check What's Blocking You

```bash
prs --blocked
```

Perfect for morning standup or shell initialization.

### Monitor PRs in Real-Time

```bash
prs --watch
```

Updates every 60 seconds. Great for dedicated terminals or low-power displays.

### Filter by Organization

```bash
# Exclude specific orgs
prs --exclude-orgs google,kubernetes

# Useful when you contribute to many orgs but only care about some
```

### Include Stale PRs

```bash
prs --include-stale
```

By default, PRs untouched for 90+ days are filtered out. Use this flag to see them.

### Check Someone Else's PRs

```bash
prs --user alice
```

Useful for team leads or pair programming.

### Disable Colors

```bash
NO_COLOR=1 prs --blocked
```

Useful for piping output or terminals with limited color support.

### Shell Integration

Add to your `.bashrc` or `.zshrc`:

```bash
# Show blocking PRs on shell startup
prs --blocked
```

## Real-Time Updates

The CLI supports two modes:

### With Ready to Review GitHub App

- **Real-time webhooks**: Instant notifications when PR status changes
- **Minimal polling**: Only polls when needed
- **Install**: [Ready to Review GitHub App](github-bot.md)

### Without the App

- **1-minute polling**: Checks GitHub every 60 seconds
- **Still effective**: Fast enough for most workflows
- **Rate limit friendly**: Respects GitHub API limits

!!! tip "Hybrid Approach"
    The CLI combines WebSocket + polling for reliability. Display only updates when content actually changes.

## How It Works

### PR Discovery

The CLI finds PRs in two ways:

1. **Query 1**: `is:open is:pr involves:{username}` - PRs you're involved with
2. **Query 2**: `is:open is:pr user:{username}` - PRs you authored

Results are deduplicated and merged.

### Blocking Status Detection

The CLI uses sophisticated logic to determine if a PR is blocking on you:

- **Turn Server Integration**: Uses Turn API's `NextAction` field for accurate blocking detection
- **Fallback**: Checks GitHub's `RequestedReviewers` list
- **Cache**: Turn API responses cached locally for 10 days

### Stale PR Filtering

PRs unchanged for 90+ days are automatically hidden unless you use `--include-stale`.

## Configuration

### Authentication

The CLI uses GitHub CLI's authentication:

```bash
# Check current auth status
gh auth status

# Login if needed
gh auth login
```

### Environment Variables

| Variable | Purpose |
|----------|---------|
| `GITHUB_USER` | Override which user's PRs to view |
| `NO_COLOR=1` | Disable colored output |

### Cache

Turn API responses are cached locally in `prs-turn-cache` with a 10-day TTL. Use `--no-cache` to disable.

## Troubleshooting

### No PRs showing up

1. **Check authentication**: `gh auth status`
2. **Verify PRs exist**: Check GitHub web interface
3. **Try verbose mode**: `prs --verbose`

### Colors not working

- Some terminals don't support full color
- Use `NO_COLOR=1 prs` to disable colors
- Check terminal emulator settings

### Rate limiting

- GitHub API has rate limits
- The CLI caches Turn API responses to reduce requests
- Wait a few minutes if you hit the limit
- Webhooks (via GitHub App) reduce API calls significantly

### Authentication failed

```bash
# Check auth status
gh auth status

# Re-authenticate
gh auth login
```

### Slow performance

- Turn API calls are cached for 10 days
- First run may be slow while populating cache
- Use `--no-cache` to debug caching issues

## Desktop Alternative

Prefer a GUI? Check out [reviewGOOSE:Desktop](goose.md) - native desktop notifications with sound effects.

Both tools use the same backend and can be used together.

## Related

- [GitHub Bot](github-bot.md) - Install for real-time updates
- [Desktop App](goose.md) - GUI alternative
- [Getting Started](getting-started.md) - reviewGOOSE overview
