# Configuration Reference

Complete configuration guide for grooveASSIGN.

## Configuration File

Create `.grooveassign.yml` in the root of your repository.

```yaml
# .grooveassign.yml
reviewers:
  count: 2
  prefer_codeowners: false
  fallback_to_blame: true

filters:
  exclude_users:
    - dependabot[bot]
    - renovate[bot]
  exclude_patterns:
    - "vendor/**"
    - "**/*.generated.go"
    - "**/*.pb.go"

timing:
  timezone_aware: true
  prefer_available: true

advanced:
  blame_depth: 500
  recency_weight: true
  min_commits: 5
```

---

## Reviewer Assignment

### `reviewers.count`

Number of reviewers to assign per PR.

- **Type**: `integer`
- **Default**: `2`
- **Range**: `1-5`

**Example**:

```yaml
reviewers:
  count: 3  # Assign 3 reviewers
```

!!! tip
    More reviewers = more eyes, but also more coordination overhead. 2-3 is optimal for most teams.

### `reviewers.prefer_codeowners`

Whether to check CODEOWNERS file before running blame analysis.

- **Type**: `boolean`
- **Default**: `false`

**Behavior**:

- `true`: Check CODEOWNERS first, only use blame if no owners found
- `false`: Always use git blame analysis

**Example**:

```yaml
reviewers:
  prefer_codeowners: true
  fallback_to_blame: true  # Use blame if CODEOWNERS has no match
```

**When to use**:

- ✅ You have well-maintained CODEOWNERS file
- ✅ Code ownership is clearly defined
- ❌ CODEOWNERS is stale or incomplete
- ❌ You want expertise over organizational structure

### `reviewers.fallback_to_blame`

When `prefer_codeowners: true`, whether to fall back to blame analysis if CODEOWNERS has no match.

- **Type**: `boolean`
- **Default**: `true`

**Example**:

```yaml
reviewers:
  prefer_codeowners: true
  fallback_to_blame: false  # Don't assign anyone if CODEOWNERS missing
```

### `reviewers.require_approval_count`

Minimum reviewers who must approve before PR can merge.

- **Type**: `integer`
- **Default**: `null` (don't set requirement)
- **Range**: `1-5`

**Example**:

```yaml
reviewers:
  count: 3
  require_approval_count: 2  # Assign 3, require 2 approvals
```

!!! note
    This sets GitHub branch protection rules. Requires admin permissions.

---

## Filters

### `filters.exclude_users`

GitHub usernames to never assign as reviewers.

- **Type**: `array[string]`
- **Default**: `[]`

**Example**:

```yaml
filters:
  exclude_users:
    - dependabot[bot]
    - renovate[bot]
    - github-actions[bot]
    - pr-author-bot
```

**Common exclusions**:

- Bot accounts
- Service accounts
- Automated PR creators
- Inactive users

!!! tip
    PR author is automatically excluded - no need to add explicitly.

### `filters.exclude_patterns`

Glob patterns for files to ignore when analyzing blame.

- **Type**: `array[string]`
- **Default**: `[]`

**Example**:

```yaml
filters:
  exclude_patterns:
    - "vendor/**"
    - "node_modules/**"
    - "**/*.generated.go"
    - "**/*.pb.go"
    - "**/*_test.go"
    - "docs/**"
    - "*.md"
```

**Pattern syntax**:

- `*` - Match any characters except `/`
- `**` - Match any characters including `/`
- `?` - Match single character
- `[abc]` - Match any character in brackets

**Why exclude files**:

- Generated code (protobuf, GraphQL, etc.)
- Dependencies (vendor, node_modules)
- Test files (if you want prod experts only)
- Documentation (if you have dedicated docs reviewers)

### `filters.include_teams`

Only assign reviewers from these GitHub teams.

- **Type**: `array[string]`
- **Default**: `null` (no restriction)

**Example**:

```yaml
filters:
  include_teams:
    - backend-team
    - platform-team
```

**Team names**:

Use the team slug (lowercase, hyphenated), not display name.

Find team slug in GitHub URL: `github.com/orgs/YOURORG/teams/TEAM-SLUG`

### `filters.exclude_teams`

Never assign reviewers from these teams.

- **Type**: `array[string]`
- **Default**: `[]`

**Example**:

```yaml
filters:
  exclude_teams:
    - contractors
    - interns
```

### `filters.min_contributions`

Minimum number of commits to file before eligible as reviewer.

- **Type**: `integer`
- **Default**: `5`

**Example**:

```yaml
filters:
  min_contributions: 10  # Must have 10+ commits to file
```

**Trade-offs**:

- **Higher**: Only senior contributors, may have few candidates
- **Lower**: More candidates, but less expertise

### `filters.max_workload`

Maximum number of open PR reviews before skipping this reviewer.

- **Type**: `integer`
- **Default**: `10`

**Example**:

```yaml
filters:
  max_workload: 5  # Skip reviewers with 5+ open PRs
```

Prevents overloading busy developers.

---

## Timing

### `timing.timezone_aware`

Use timezone detection to prefer reviewers likely to be online.

- **Type**: `boolean`
- **Default**: `false`

**Example**:

```yaml
timing:
  timezone_aware: true
```

**How it works**:

1. Detect contributor timezones via gitIDENTITY
2. Check current time in their timezone
3. Boost score for reviewers in working hours
4. Reduce score for reviewers likely sleeping

**Requires**:

- Contributors have public GitHub activity
- At least 50 commits per contributor

### `timing.prefer_available`

Boost reviewers active in the current hour based on historical patterns.

- **Type**: `boolean`
- **Default**: `false`

**Example**:

```yaml
timing:
  prefer_available: true
```

**Score adjustments**:

| Availability | Score Boost |
|--------------|-------------|
| Active this hour historically | +30% |
| Active next hour | +20% |
| Active in 2 hours | +10% |
| Not active for 3+ hours | -25% |

### `timing.timezone_overrides`

Manually specify timezones for users.

- **Type**: `map[string]string`
- **Default**: `{}`

**Example**:

```yaml
timing:
  timezone_overrides:
    alice: "America/New_York"
    bob: "Europe/London"
    charlie: "Asia/Tokyo"
```

Use IANA timezone names. Find yours at [timeapi.io/api/Time/current/zone](https://timeapi.io/api/Time/current/zone).

---

## Advanced

### `advanced.blame_depth`

Maximum number of commits to analyze per file.

- **Type**: `integer`
- **Default**: `500`
- **Range**: `10-10000`

**Example**:

```yaml
advanced:
  blame_depth: 100  # Only check last 100 commits
```

**Trade-offs**:

- **Higher**: More accurate, slower analysis
- **Lower**: Faster, but may miss historical experts

### `advanced.recency_weight`

Apply time-decay weighting to older commits.

- **Type**: `boolean`
- **Default**: `true`

**Example**:

```yaml
advanced:
  recency_weight: false  # All commits weighted equally
```

**Weighting when enabled**:

- Last 30 days: 100% weight
- 30-90 days: 50% weight
- 90+ days: 25% weight

**When to disable**:

- Small teams where everyone knows everything
- Stable codebases with infrequent changes
- You want original authors, not recent editors

### `advanced.min_commits`

Minimum total commits required to be eligible as reviewer.

- **Type**: `integer`
- **Default**: `5`

**Example**:

```yaml
advanced:
  min_commits: 20  # Must have 20+ commits to any file
```

Filters out junior developers or new team members.

### `advanced.cache_ttl`

How long to cache blame analysis results (in hours).

- **Type**: `integer`
- **Default**: `24`
- **Range**: `1-168` (1 hour to 1 week)

**Example**:

```yaml
advanced:
  cache_ttl: 1  # Recompute blame every hour
```

**Trade-offs**:

- **Higher**: Faster PR assignment, may be stale
- **Lower**: Always fresh, slower and more API calls

---

## Complete Example

Realistic configuration for a mid-size engineering team:

```yaml
# .grooveassign.yml

# Assign 2 reviewers, prefer CODEOWNERS but fall back to blame
reviewers:
  count: 2
  prefer_codeowners: true
  fallback_to_blame: true

# Exclude bots and generated files
filters:
  exclude_users:
    - dependabot[bot]
    - renovate[bot]
    - github-actions[bot]

  exclude_patterns:
    # Dependencies
    - "vendor/**"
    - "node_modules/**"
    - "package-lock.json"
    - "yarn.lock"

    # Generated code
    - "**/*.generated.*"
    - "**/*.pb.go"
    - "**/*_pb2.py"

    # Build artifacts
    - "dist/**"
    - "build/**"

  # Only assign from engineering teams
  include_teams:
    - backend
    - frontend
    - platform

  # Skip overloaded reviewers
  max_workload: 7

  # Require at least 10 commits to be eligible
  min_contributions: 10

# Timezone-aware assignment
timing:
  timezone_aware: true
  prefer_available: true

  # Override for remote workers
  timezone_overrides:
    alice: "America/Los_Angeles"  # Works PST
    bob: "Europe/Berlin"          # Works CET

# Performance tuning
advanced:
  blame_depth: 200        # Check last 200 commits
  recency_weight: true    # Prefer recent contributors
  min_commits: 15         # Minimum 15 total commits
  cache_ttl: 12           # Cache for 12 hours
```

---

## Configuration Precedence

If configuration files exist in multiple locations:

1. **Repository root** (`.grooveassign.yml`)
2. **Organization default** (`.github/.grooveassign.yml` in `.github` repo)
3. **Built-in defaults**

---

## Validation

Validate your configuration before committing:

```bash
# Check YAML syntax
yamllint .grooveassign.yml

# Test with grooveASSIGN (dry-run)
gh api repos/:owner/:repo/pulls/:pr_number \
  --jq '.changed_files' | \
  grep -v "node_modules" | \
  head -5
```

---

## Common Configurations

### Minimal (use defaults)

```yaml
reviewers:
  count: 2
```

### Small team (everyone reviews everything)

```yaml
reviewers:
  count: 1

filters:
  exclude_users:
    - dependabot[bot]

advanced:
  recency_weight: false  # All history counts equally
```

### Large team (strict filtering)

```yaml
reviewers:
  count: 3
  require_approval_count: 2

filters:
  include_teams:
    - senior-engineers
  max_workload: 5
  min_contributions: 20

timing:
  timezone_aware: true

advanced:
  blame_depth: 100
  min_commits: 50
```

### OSS project (prefer maintainers)

```yaml
reviewers:
  count: 2
  prefer_codeowners: true
  fallback_to_blame: true

filters:
  exclude_users:
    - dependabot[bot]
    - renovate[bot]

  exclude_patterns:
    - "docs/**"
    - "*.md"

advanced:
  recency_weight: true
  min_commits: 25  # Only assign established contributors
```

---

## Troubleshooting

See [Troubleshooting](troubleshooting.md#configuration) for common configuration issues.

---

## Questions?

- [GitHub Discussions](https://github.com/codegroove/grooveassign/discussions)
- [Support](https://codegroove.dev/support)
