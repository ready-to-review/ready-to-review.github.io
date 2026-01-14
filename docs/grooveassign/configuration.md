# Configuration

Configure grooveASSIGN per-organization using `.codeGROOVE/assigner.yaml`.

## Configuration File

Create `.codeGROOVE/assigner.yaml` in any repository in your organization. The configuration applies to all repositories in that organization.

```yaml
# Timing
min_grace_period: 2        # Minutes before assignment
pending_test_grace: 20     # Minutes to wait while tests are pending
failing_test_grace: 90     # Minutes to wait while tests are failing
min_age: 0                 # Minimum PR age in hours
max_age: 8760              # Maximum PR age in hours (default: 1 year)

# Assignment limits
max_reviewers: 2           # Maximum reviewers to assign
max_prs_per_reviewer: 9    # Skip reviewers with more than this many open PRs

# Exclusions
excluded_users:
  - bot-account
  - dependabot[bot]

excluded_paths:
  - "vendor/**"
  - "**/*.generated.go"
  - "**/*.pb.go"
```

## Options Reference

### Timing Options

| Option | Default | Description |
|--------|---------|-------------|
| `min_grace_period` | `2` | Minutes to wait before assigning reviewers to a new PR |
| `pending_test_grace` | `20` | Minutes to wait while CI tests are still running |
| `failing_test_grace` | `90` | Minutes to wait while CI tests are failing |
| `min_age` | `0` | Minimum PR age in hours before considering for assignment |
| `max_age` | `8760` | Maximum PR age in hours (PRs older than this are skipped) |

### Assignment Options

| Option | Default | Description |
|--------|---------|-------------|
| `max_reviewers` | `2` | Maximum number of reviewers to assign per PR |
| `max_prs_per_reviewer` | `9` | Skip reviewers who already have this many open PR reviews |

### Exclusions

| Option | Description |
|--------|-------------|
| `excluded_users` | List of usernames to never assign as reviewers |
| `excluded_paths` | Glob patterns for files to ignore when calculating ownership |

## Path Patterns

Excluded paths use glob patterns:

- `vendor/**` - All files under vendor/
- `**/*.generated.go` - All .generated.go files in any directory
- `docs/**` - All documentation files
- `*.md` - All markdown files in root

## Multiple Configurations

If `.codeGROOVE/assigner.yaml` exists in multiple repositories, grooveASSIGN uses the configuration from the repository where the PR is opened.
