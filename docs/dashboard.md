# Dashboard

Web interface at `<org>.ready-to-review.dev` showing all PRs across your organization.

## Access

Navigate to `<your-org>.ready-to-review.dev` (replace `<your-org>` with your GitHub org name).

Click **Login with GitHub**, authorize when prompted.

Sessions expire after 24 hours.

## Interface

**Incoming**: PRs where you're assigned reviewer

**Outgoing**: PRs you created waiting for review or changes

**Drafts**: Your draft PRs not ready for review

### Status Colors

- 🔴 Red: Action required from you (fix CI, address feedback, resolve conflicts)
- 🟡 Yellow: Waiting on others (awaiting review)
- 🟢 Green: Approved, ready to merge
- ⚪ Gray: Draft or CI running

Work red first, then yellow, then merge green.

### Search & Filter

Search box: Filter by PR title, repo name, author, or reviewer

Repository dropdown: Show PRs from specific repos only

Sort by: Updated, Created, Title, Repository

## Security

OAuth scopes requested:

- `user:read` - Your username and profile
- `repo:status` - PR status and CI checks
- `read:org` - Organization membership

Data cached up to 28 days. No code access. Details: [Security](security.md)

## Troubleshooting

**Can't log in**: Clear cookies for `*.ready-to-review.dev`, try incognito mode. Check GitHub Settings → Applications → Authorized OAuth Apps.

**No PRs shown**: Verify GitHub App installed on repos. Check [GitHub Settings → Installed GitHub Apps](https://github.com/settings/installations). Free plans don't include private repos.

**Wrong status**: Hard refresh (Ctrl+Shift+R or Cmd+Shift+R). Status cached up to 5 minutes.

**Slow**: Use repository filtering. Clear browser cache.

More: https://github.com/codeGROOVE-dev/support
