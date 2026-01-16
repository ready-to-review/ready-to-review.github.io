# reviewGOOSE:Slack

Posts PR updates to channels and sends DMs when action is needed.

## Install

1. [Add to Slack](https://slack.com/oauth/v2/authorize?client_id=9426269265270.9443955134789&scope=channels:history,channels:read,chat:write,chat:write.public,commands,im:write,reactions:write,team:read,users:read,users:read.email,groups:read,groups:history)
2. Select your workspace and click **Allow**
3. Invite the bot to channels: `/invite @goose`

## Channel Mapping

By default, repos auto-map to same-named channels:

- `api-server` repo → `#api-server` channel
- `mobile-app` repo → `#mobile-app` channel

### Custom Mapping

Create `.codeGROOVE/slack.yaml` in your org:

```yaml
global:
    team_id: T09XXXXXXXX   # Your Slack workspace ID

channels:
    engineering:
        repos:
            - api-server
            - mobile-app
    all-prs:
        repos:
            - "*"  # Catch-all
```

Find your Team ID: Slack → Settings → Workspace Settings → look at the URL.

## Notification Timing

```yaml
global:
    team_id: T09XXXXXXXX
    reminder_dm_delay: 65   # Minutes before DM (0 = immediate)
    daily_reminders: true   # 8-9am local time
    when: passing           # When to post threads (see below)
```

If user is in the channel, DM is delayed 65 minutes. If not, immediate DM.

## Thread Posting Thresholds

Control when PR threads are created in channels using the `when` setting:

```yaml
global:
    when: passing   # Default for all channels

channels:
    critical-infra:
        repos:
            - api-server
        when: immediate  # Override for critical repos
```

| Value | When Thread Posts | Use Case |
|-------|------------------|----------|
| `immediate` | As soon as PR is created (default) | Critical repos requiring immediate attention |
| `assigned` | When PR has reviewers or assignees | Ensure someone is responsible before notifying |
| `blocked` | When someone needs to take action | Most repos - reduce noise from draft PRs |
| `passing` | When tests pass and ready for review | Quality-focused teams - only notify when CI is green |

**Note**: This only affects thread **creation**. Thread **updates** and DMs remain immediate. Merged/closed PRs always post regardless of threshold.

## Commands

- `/goose dashboard` - Open the dashboard
- `/goose help` - Show help

## Troubleshooting

**No messages**: Invite bot with `/invite @goose`. Check `slack.yaml` syntax.

**No DMs**: Verify GitHub email matches Slack email. Check `reminder_dm_delay` setting.

**Wrong channel**: Check `slack.yaml` for typos. Explicit mappings override auto-discovery.
