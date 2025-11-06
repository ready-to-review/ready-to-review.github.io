# GitHub Reviewer Bot

Automatically assigns reviewers based on code ownership and current workload.

## How It Works

When you create a PR:

1. Bot runs `git blame` on changed files
2. Scores candidates by code ownership percentage
3. Filters out bots and overloaded reviewers (>9 active PRs)
4. Assigns top 1-3 reviewers
5. Triggers notifications

Runs within 15-30 seconds of PR creation.

## Assignment Algorithm

**Code ownership** (highest weight): Who authored the most lines in changed files?

**Workload** (high weight): How many open PRs does reviewer have? Excludes if >9 active (non-stale) PRs.

**Activity** (medium weight): Recent GitHub activity

**Timezone** (low weight): Slight preference for reviewers in active hours

**Filtered out**: Bots (`dependabot`, `renovate`, etc.), service accounts, inactive users, PR author

## Workload Calculation

Counts only non-stale open PRs. PRs untouched for >180 days are considered stale and don't count.

Example: Bob has 12 assigned PRs. 3 updated recently, 9 stale. Effective workload: 3 PRs. Bob eligible for assignment.

## Configuration

Enabled automatically with GitHub App installation. No additional config.

Bot only runs on repos where GitHub App is installed.

To add repos: [GitHub Settings → Installed GitHub Apps](https://github.com/settings/installations) → Ready-to-Review → Configure → Add repositories

## Behavior

**Draft PRs**: Not assigned until marked ready for review

**Manual assignments**: Bot won't override. Add/remove reviewers manually anytime.

**Reassignment**: Bot won't reassign if you remove reviewers. To trigger reassignment, close and reopen PR.

## GitHub Permissions

Required permissions:

- Pull requests: Read & Write (to assign reviewers)
- Repository contents: Read (for `git blame`)
- Repository metadata: Read
- Organization members: Read (to find candidates)

No access to: Source code contents, commit diffs, comments, issues, secrets

Details: [Security](security.md)

## Troubleshooting

**No reviewers assigned**: Check if PR is draft (mark ready for review). Verify GitHub App installed on repo. Check if all candidates overloaded (>9 PRs). Wait 60 seconds.

**Wrong reviewer assigned**: Remove manually, add correct reviewer. Bot learns from `git blame`, so recent code authors are assigned. Context matters more than history sometimes.

**Same person always assigned**: That person likely authored most code. Distribute code ownership by having others contribute to same areas. Check workload distribution in dashboard.

**Want to exclude someone**: No built-in exclusion list yet. Manually remove if assigned. Feature request: https://github.com/codeGROOVE-dev/support

**CODEOWNERS support**: Not yet implemented. Bot uses actual Git history instead of declared ownership. Planned feature.

More: https://github.com/codeGROOVE-dev/support
