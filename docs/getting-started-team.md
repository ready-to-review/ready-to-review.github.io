# Team Use Setup

This guide walks you through setting up reviewGOOSE for your team. You'll create a configuration repository, install the GitHub App, configure Slack notifications, set up the web dashboard, and optionally add desktop notifications.

**Time required:** ~15 minutes

!!! important "GitHub App Required"
    The reviewGOOSE Real-Time GitHub App is required for:

    - **Real-time notifications** (under 1 second)
    - **Slack integration** (server needs to know which repos to track)
    - **Private repository access** (Pro/Flock plans)

    Install it on all organizations where you want PR tracking.

---

## Step 1: Create Configuration Repository

reviewGOOSE uses a special `.codeGROOVE` repository in your GitHub organization to store configuration files.

1. Go to your GitHub organization: `https://github.com/your-org`
2. Click **New repository**
3. Name it `.codeGROOVE` (note the leading dot)
4. Choose **Private** (recommended) or **Public**
5. Click **Create repository**

!!! tip "Why create this first?"
    Creating `.codeGROOVE` before installing the GitHub App ensures you can select it during installation. The app needs "Contents: Read" access to this repository to read your configuration files.

---

## Step 2: Install GitHub App

--8<-- "docs/.snippets/github-app-install.md"

!!! warning "Important: Include .codeGROOVE Repository"
    When selecting repositories during installation, **you must include the `.codeGROOVE` repository**. The app needs "Contents: Read" permission (already requested) to access `.codeGROOVE/slack.yaml` and other configuration files.

---

## Step 3: View Dashboard

Visit your organization's dashboard at `<your-org>.reviewgoose.dev` (e.g., [kubernetes.reviewgoose.dev](https://kubernetes.reviewgoose.dev)), login with GitHub, and view your PRs organized by incoming (waiting on you) and outgoing (waiting on others).

The dashboard shows PRs from your organization and uses color-coded text badges like "ready to merge", "blocked on you", and "checks passing".

---

## Step 4: Configure Slack

### Install the Slack App

1. Visit: [Add to Slack](https://slack.com/oauth/v2/authorize?client_id=9426269265270.9443955134789&scope=channels:history,channels:read,chat:write,chat:write.public,commands,im:write,reactions:write,team:read,users:read,users:read.email,groups:read,groups:history&user_scope=)

2. Select your Slack workspace and click **Allow**

!!! info "Privacy"
    The Slack app only accesses channels you explicitly invite it to.

### Configure Slack Mapping

This step connects your Slack workspace to your GitHub organization.

#### Find Your Slack Team ID

You'll need this to validate that notifications go to the correct workspace.

=== "Via Workspace Settings"

    1. In Slack, click your workspace name in the top-left
    2. Select **Settings & administration** → **Workspace settings**
    3. Look at the URL in your browser address bar
    4. Your Team ID is in the URL (format: `T09CJ7X7T7Y`)
    5. Copy this ID

=== "Via Slack API Tester"

    1. Visit [api.slack.com/methods/auth.test/test](https://api.slack.com/methods/auth.test/test)
    2. Click **Test Method**
    3. Copy the `team_id` from the response

#### Create Slack Configuration

In your `.codeGROOVE` repository, create `slack.yaml`:

=== "Evaluating (Minimal)"

    ```yaml
    global:
        team_id: T09CJ7X7T7Y        # Your Slack Team ID from step above
        email_domain: company.com   # Maps GitHub emails to Slack (alice@company.com → @alice)

    channels:
        engineering:                 # Slack channel name (no # symbol)
            repos:
                - api-server         # GitHub repository name
    ```

    Replace the team_id, email_domain, channel, and repo with your values.

=== "Full Deployment"

    ```yaml
    global:
        team_id: T09CJ7X7T7Y
        email_domain: company.com

    channels:
        engineering:
            repos:
                - api-server
                - mobile-app
        general:                    # Catch-all for unmapped repos
            repos:
                - "*"
    ```

    **Auto-discovery:** Repos automatically map to same-named channels (e.g., `backend` repo → `#backend` channel). Only configure explicitly to override.

#### Commit and Push Configuration

1. Add the file: `git add slack.yaml`
2. Commit: `git commit -m "Configure reviewGOOSE Slack integration"`
3. Push: `git push`

The app will automatically detect your configuration within 5 minutes.

### Invite Bot to Channels

Now invite the bot to the Slack channels where you want PR notifications:

1. Open the Slack channel (e.g., `#engineering` or `#test-repo`)
2. Type and send: `/invite @goose`
3. Repeat for each channel you want to receive notifications

!!! warning "Critical Step"
    The bot can only post to channels it's been invited to. Even with perfect configuration, you won't see messages until you invite the bot to the channel.

!!! tip "Evaluating?"
    Create a dedicated test channel like `#r2r-test` to keep evaluation separate from your team's regular channels.

### Verify Slack Integration

Create a test PR and confirm it appears in your Slack channel within seconds with status emoji updates.

### Optional: Customize Notifications

Want to adjust notification timing? Add these settings to your `slack.yaml`:

```yaml
global:
    team_id: T09CJ7X7T7Y
    email_domain: yourcompany.com
    reminder_dm_delay: 65  # Minutes to wait before DMing (default: 65)
    daily_reminders: true  # Send 8-9am reminders (default: false)
```

**Smart DM logic:**

- If a reviewer is in the channel where they're tagged → Wait 65 minutes before sending DM
- If a reviewer is NOT in that channel → Send DM immediately
- Only one DM per user per PR, even if posted to multiple channels

See [Slack Integration](slack.md#advanced-configuration) for complete configuration options.

---

## Step 5: Desktop Integration (Optional)

--8<-- "docs/.snippets/desktop-integration-goose.md"

---

## You're All Set! 🎉

Your team is now set up with reviewGOOSE. PRs will automatically appear in Slack channels with smart notifications to reviewers.

## Next Steps

Explore [Dashboard](dashboard.md), [Slack](slack.md), [Goose](goose.md), or [GitHub Bot](github-bot.md) documentation. For issues, see [Troubleshooting](troubleshooting.md) or visit [support](https://github.com/codeGROOVE-dev/support).
