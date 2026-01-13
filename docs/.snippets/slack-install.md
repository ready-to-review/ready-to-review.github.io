### Install the Slack App

1. Visit: [Add to Slack](https://slack.com/oauth/v2/authorize?client_id=9426269265270.9443955134789&scope=channels:history,channels:read,chat:write,chat:write.public,commands,im:write,reactions:write,team:read,users:read,users:read.email,groups:read,groups:history&user_scope=)

2. Select your Slack workspace and click **Allow**

!!! info "Privacy"
    The Slack app only accesses channels you explicitly invite it to.

### Configure Slack Mapping

This step connects your Slack workspace to your GitHub organization.

#### Create Configuration Repository

1. Go to your GitHub organization: `https://github.com/your-org`
2. Click **New repository**
3. Name it `.codeGROOVE` (note the leading dot)
4. Choose **Public** or **Private** - your choice
5. Click **Create repository**

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
