# Getting Started with grooveASSIGN

Get automated PR reviewer assignment in under 5 minutes.

## Install the GitHub App

1. Visit [github.com/apps/grooveassign](https://github.com/apps/grooveassign)
2. Click **Install**
3. Select the organization or repositories you want to enable
4. Grant the required permissions

### Required Permissions

- **Repository**: Write access (to assign reviewers)
- **Pull requests**: Write access (to modify PR reviewers)
- **Organization members**: Read access (to check team membership)

## Configuration (Optional)

Create `.codeGROOVE/assigner.yaml` in any repository in your organization:

```yaml
min_grace_period: 2        # Minutes before assignment
pending_test_grace: 20     # Minutes while tests pending
failing_test_grace: 90     # Minutes while tests failing
max_reviewers: 2
max_prs_per_reviewer: 9

excluded_users:
  - bot-account

excluded_paths:
  - "vendor/**"
  - "**/*.generated.go"
```

See [Configuration](configuration.md) for all available options.

## Verify Installation

1. Open a new PR without requesting reviewers
2. Wait for the grace period (default: 2 minutes)
3. grooveASSIGN will automatically assign reviewers based on code ownership

## Next Steps

- [Configuration](configuration.md) - Customize assignment behavior
