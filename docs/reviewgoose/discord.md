# reviewGOOSE:Discord

**Preview** - Discord support is currently in preview. DM notifications and daily reports are not fully tested yet.

Posts PR updates to channels and sends DMs when action is needed.

## Quick Start

1. [Add to Discord](https://discord.com/oauth2/authorize?client_id=1461368540190871831&permissions=2147485696&scope=bot%20applications.commands)
2. Select your server and click **Authorize**
3. Try `/goose dash` to see your PRs
4. For private channels: manually add the bot via channel settings

That's it! By default, repos auto-map to same-named channels (`api-server` repo → `#api-server` channel).

## Commands

All commands start with `/goose`:

| Command | Description |
|---------|-------------|
| `/goose dash` | View your PRs and dashboard links |
| `/goose status` | Bot status and statistics |
| `/goose users` | GitHub to Discord user mappings |
| `/goose channels` | Repository to channel mappings |
| `/goose help` | Show command reference |

## Configuration

Create `.codeGROOVE/discord.yaml` in your GitHub org to customize mappings:

```yaml
global:
    guild_id: "1234567890123456789"   # Your Discord server ID
    reminder_dm_delay: 65              # Minutes before DM (0 = immediate)
    when: passing                      # When to post threads (see below)

users:
    alice: "111111111111111111"  # GitHub username → Discord user ID
    bob: "222222222222222222"

channels:
    # Manual channel mapping
    engineering:
        repos:
            - api-server
            - mobile-app
        reminder_dm_delay: 30   # Override per channel
        when: blocked           # Override thread posting threshold
        type: forum              # "forum" or "text"

    # Catch-all channel
    all-prs:
        repos:
            - "*"  # All repos

    # Mute auto-discovered channel
    noisy-repo:
        mute: true  # Disable notifications for this channel
```

**Find Guild ID**: Settings → Advanced → Enable Developer Mode, then right-click server name → Copy Server ID.

**Muting channels**: Add any channel name with `mute: true` to disable automatic notifications. Useful for repos that auto-map to channels you want to silence.

## Thread Posting Thresholds

Control when PR threads are created in channels using the `when` setting:

| Value | When Thread Posts | Use Case |
|-------|------------------|----------|
| `immediate` | As soon as PR is created (default) | Critical repos requiring immediate attention |
| `assigned` | When PR has reviewers or assignees | Ensure someone is responsible before notifying |
| `blocked` | When someone needs to take action | Most repos - reduce noise from draft PRs |
| `passing` | When tests pass and ready for review | Quality-focused teams - only notify when CI is green |

**Note**: This only affects thread **creation**. Thread **updates** and DMs remain immediate. Merged/closed PRs always post regardless of threshold.

**Example**: Set `when: passing` globally to only create threads after tests pass, then override with `when: immediate` for critical repos like `api-server`.

## How It Works

**User Mapping** (GitHub → Discord):
1. Explicit mapping in `users:` section
2. Username match (searches Discord server)
3. Fallback (mentions GitHub username as plain text)

**Channel Types**:
- **Forum channels**: Each PR gets its own thread (recommended)
- **Text channels**: PR updates appear as regular messages

**DM Timing**: If you're in the channel, DMs are delayed 65 minutes. If not in channel, immediate DM. Activity reports sent when you come online if you have pending PRs and 20+ hours since last report.

## Troubleshooting

**No messages in private channels**: Add bot to channel permissions (Edit Channel → Permissions → Add reviewGOOSE → Enable "View Channel").

**No DMs**: User must share the server with the bot and have DMs enabled from server members.

**Wrong channel**: Check `discord.yaml` for typos. Explicit mappings override auto-discovery.
