# Troubleshooting

Common issues and solutions for reviewGOOSE.

## GitHub App

### App not installed

**Problem**: reviewGOOSE isn't tracking PRs in your repository.

**Solution**:

1. Visit the [GitHub App installation page](https://github.com/apps/reviewgoose)
2. Click "Configure"
3. Select the repositories you want to enable
4. Click "Save"

### Permissions issues

**Problem**: reviewGOOSE can't read PR data or post comments.

**Solution**:

The app requires these permissions:

- **Read access**: Pull requests, repository contents, commit statuses
- **Write access**: Pull request comments, checks

If permissions were denied during installation:

1. Go to repository Settings → GitHub Apps
2. Click "Configure" next to reviewGOOSE
3. Review and accept required permissions

### PRs not being tracked

**Problem**: New PRs aren't showing up in the dashboard.

**Solution**:

1. Verify the repository is in your installation (Settings → GitHub Apps)
2. Check that the PR isn't from a fork (forks require additional permissions)
3. Ensure the repository isn't archived
4. Wait up to 60 seconds for initial sync

## Notifications

### Not receiving Slack notifications

**Problem**: reviewGOOSE isn't sending Slack messages when PRs need attention.

**Solution**:

1. Verify Slack integration is connected at `<org>.reviewgoose.dev/settings`
2. Check that your GitHub email matches your Slack email
3. Ensure the Slack bot has permission to DM you
4. Check Slack notification preferences (bell icon in app)

!!! tip
    Message the reviewGOOSE bot in Slack with `status` to verify your connection.

### Not receiving desktop notifications

**Problem**: Desktop app installed but no notifications appearing.

**Solution**:

1. Check system notification settings:
   - **macOS**: System Settings → Notifications → reviewGOOSE
   - **Windows**: Settings → System → Notifications → reviewGOOSE
   - **Linux**: Settings → Notifications → reviewGOOSE
2. Verify you're logged in (check app menu bar icon)
3. Restart the desktop app
4. Check that "Do Not Disturb" mode is off

### Duplicate notifications

**Problem**: Receiving notifications in multiple places for the same PR.

**This is expected behavior**:

reviewGOOSE intentionally sends notifications through all connected channels (Slack, Discord, Desktop) to ensure you never miss a PR waiting on you.

**To reduce duplicates**:

1. Disable desktop notifications in app preferences
2. Mute Slack DMs and rely on channel posts
3. Choose your preferred notification method and disconnect others

## Dashboard

### Dashboard not loading

**Problem**: `<org>.reviewgoose.dev` shows an error or blank page.

**Solution**:

1. Verify you're logged in with your GitHub account
2. Clear browser cache and cookies for `reviewgoose.dev`
3. Try a different browser or incognito mode
4. Check [status.reviewgoose.dev](https://status.reviewgoose.dev) for outages

### PRs missing from dashboard

**Problem**: PRs exist on GitHub but don't appear in reviewGOOSE.

**Solution**:

1. Ensure the repository is included in your GitHub App installation
2. Check if PR is in a private repo (requires paid plan)
3. Wait up to 60 seconds for sync
4. Click "Refresh" in dashboard header

### Wrong turn detection

**Problem**: reviewGOOSE says it's your turn but you already reviewed/updated.

**Solution**:

Turn detection updates when these events occur:

- New commits pushed
- Review submitted (approved, changes requested, commented)
- CI status changes
- PR marked ready for review

**If still incorrect after these actions**:

1. Force refresh the dashboard
2. Check GitHub webhooks in repository settings → Webhooks
3. Contact support with PR URL

## Turn Detection

### "Waiting on author" but tests passing

**Problem**: reviewGOOSE shows "waiting on author" despite passing tests.

**Explanation**:

This is correct if:

- There are unresolved review comments
- Changes were requested in the last review
- PR is marked as draft

**The author needs to**:

- Address review feedback
- Re-request review from reviewers
- Mark PR as ready (if draft)

### "Waiting on reviewer" but not assigned

**Problem**: PR shows "waiting on reviewer" but no reviewers assigned.

**Explanation**:

reviewGOOSE detects whose turn it is based on:

1. **Explicit reviewers**: If assigned, they need to review
2. **Implicit reviewers**: If no one assigned, defaults to repo members
3. **Approval requirements**: Branch protection rules requiring N approvals

**To fix**:

- Assign specific reviewers
- Request review from team members
- Configure CODEOWNERS file

### Can't merge despite approvals

**Problem**: reviewGOOSE shows "waiting on author" to merge but merge button disabled.

**Causes**:

- Required status checks failing
- Required review not approved
- Branch protection rules not satisfied
- Merge conflicts

**Check**:

1. Scroll to bottom of PR on GitHub
2. Look for red "X" or yellow warnings
3. Resolve issues listed
4. Refresh reviewGOOSE dashboard

## Performance

### Slow dashboard loading

**Problem**: Dashboard takes >5 seconds to load.

**Solution**:

1. Reduce number of tracked repositories
2. Archive old PRs (close stale PRs on GitHub)
3. Clear browser cache
4. Disable browser extensions that modify pages

### Webhook delays

**Problem**: Changes on GitHub take >60 seconds to appear in reviewGOOSE.

**Solution**:

1. Check GitHub webhook delivery in repo settings:
   - Settings → Webhooks → reviewgoose.dev
   - Click webhook → "Recent Deliveries"
   - Look for failed deliveries
2. Redeliver failed webhooks
3. Contact support if consistent delays >2 minutes

## Privacy & Security

### Concerned about data access

**Question**: What data does reviewGOOSE access?

**Answer**:

reviewGOOSE only accesses:

- PR metadata (title, description, status, reviewers)
- Commit messages and authors
- Review comments and statuses
- CI check results

reviewGOOSE **does not** access:

- Repository source code
- Issue comments (only PR comments)
- Repository secrets or credentials

See [Security](security.md) for details.

### Want to revoke access

**How to uninstall**:

1. Go to GitHub Settings → Applications → reviewGOOSE
2. Click "Revoke" to remove all access
3. Contact support to delete your data

## Still Having Issues?

If your problem isn't listed here:

1. Check [status.reviewgoose.dev](https://status.reviewgoose.dev) for known issues
2. Search [GitHub Discussions](https://github.com/codegroove/reviewgoose/discussions)
3. [Contact Support](https://codegroove.dev/support)

Include:

- PR URL if relevant
- Screenshot of issue
- Browser/OS version
- When the issue started
