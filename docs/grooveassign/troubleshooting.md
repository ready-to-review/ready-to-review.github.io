# Troubleshooting

Common issues and solutions for grooveASSIGN.

## Installation

### GitHub App not installed

**Problem**: grooveASSIGN isn't assigning reviewers to new PRs.

**Solution**:

1. Visit the [GitHub App installation page](https://github.com/apps/grooveassign)
2. Click "Configure"
3. Select the repositories you want to enable
4. Click "Save"

### Permissions issues

**Problem**: grooveASSIGN can't assign reviewers or analyze blame.

**Solution**:

The app requires these permissions:

- **Read access**: Repository contents, pull requests
- **Write access**: Pull request reviewers

If permissions were denied:

1. Go to repository Settings → GitHub Apps
2. Click "Configure" next to grooveASSIGN
3. Review and accept required permissions

## Reviewer Assignment

### No reviewers assigned

**Problem**: PR created but grooveASSIGN didn't assign anyone.

**Possible causes**:

1. **No eligible reviewers found**
   - Check that repository has multiple contributors
   - Verify PR isn't from the only active developer

2. **Configuration excludes everyone**
   - Review `.grooveassign.yml` configuration
   - Check that filters aren't too restrictive

3. **Timing issues**
   - grooveASSIGN only acts on PR creation, not updates
   - Manual assignment before grooveASSIGN runs prevents auto-assignment

**Solution**:

- Close and reopen PR to trigger reassignment
- Manually assign using GitHub UI
- Review configuration file

### Wrong reviewers assigned

**Problem**: grooveASSIGN assigned someone who doesn't know the code.

**Understanding assignment logic**:

grooveASSIGN uses line-level git blame to find developers who:

1. **Modified the most changed lines** (weighted by recency)
2. **Are currently active** (not on PTO/inactive >90 days)
3. **Are in the correct timezone** (if timezone-aware enabled)
4. **Meet configured filters** (team membership, etc.)

**Common reasons for unexpected assignments**:

- Developer recently refactored the file (blame shows them)
- Original author no longer with company (assigns current maintainer)
- Configuration prioritizes availability over expertise

**To improve assignments**:

1. Configure `.grooveassign.yml` with:
   - Team restrictions
   - Exclusion patterns
   - Timezone preferences

2. Use CODEOWNERS as fallback
3. Enable `prefer_codeowners: true` in config

### Assigning author

**Problem**: grooveASSIGN assigned PR author as reviewer.

**Solution**:

grooveASSIGN automatically excludes the PR author. If this happened:

1. PR was created by bot/automation with different author metadata
2. PR author changed after creation
3. Bug in author detection

**Workaround**:

Add to `.grooveassign.yml`:

```yaml
exclude_users:
  - bot-username
  - automation-account
```

### Not respecting CODEOWNERS

**Problem**: grooveASSIGN ignores CODEOWNERS file.

**Explanation**:

By default, grooveASSIGN uses git blame, not CODEOWNERS. This is intentional - blame finds who actually worked on code, not who "owns" it on paper.

**To use CODEOWNERS**:

Add to `.grooveassign.yml`:

```yaml
prefer_codeowners: true
fallback_to_blame: true
```

This checks CODEOWNERS first, falls back to blame if no owners found.

## Configuration

### Configuration not being read

**Problem**: Changes to `.grooveassign.yml` have no effect.

**Solution**:

1. **Verify file location**: Must be at repository root (not `.github/`)
2. **Check syntax**: YAML is whitespace-sensitive
   ```bash
   yamllint .grooveassign.yml
   ```
3. **Commit the file**: Changes must be committed to default branch
4. **Wait for sync**: Configuration updates on next PR (up to 5 minutes)

!!! tip
    Create a test PR to verify configuration changes took effect.

### Invalid configuration

**Problem**: grooveASSIGN shows configuration error.

**Common syntax errors**:

```yaml
# ❌ Wrong: Using tabs instead of spaces
reviewers:
→→→count: 2

# ✅ Correct: Use spaces
reviewers:
  count: 2

# ❌ Wrong: Missing quotes for special characters
exclude_patterns:
  - *.md

# ✅ Correct: Quote glob patterns
exclude_patterns:
  - "*.md"
```

**Validate your config**:

```bash
yamllint .grooveassign.yml
```

See [Configuration Reference](configuration.md) for all options.

### Timezone detection not working

**Problem**: `timezone_aware: true` but assignments ignore timezones.

**Requirements**:

1. User must have public activity on GitHub
2. Activity must span multiple weeks
3. User profile may optionally have location set

**Limitations**:

- New accounts (<3 months) may have insufficient data
- Users with sporadic activity get low-confidence detection
- VPN/proxy use can affect accuracy

**Check detection**:

Query the gitIDENTITY API:

```bash
curl https://finder.github.codegroove.app/api/v1/detect \
  -d '{"username":"octocat"}'
```

If `confidence < 0.5`, timezone detection is unreliable for that user.

**Workaround**:

Manually configure timezones in `.grooveassign.yml`:

```yaml
timezone_overrides:
  alice: "America/New_York"
  bob: "Europe/London"
```

## Performance

### Slow PR assignment

**Problem**: grooveASSIGN takes >30 seconds to assign reviewers.

**Causes**:

- Large PR with many changed files (analyzing blame takes time)
- Repository with deep git history
- Complex configuration with many filters

**Solutions**:

1. Reduce `reviewers.count` in configuration
2. Exclude large generated files:
   ```yaml
   exclude_patterns:
     - "package-lock.json"
     - "yarn.lock"
     - "dist/*"
   ```
3. Limit blame depth:
   ```yaml
   blame_depth: 100  # Only analyze last 100 commits
   ```

### High API usage

**Problem**: Hitting GitHub API rate limits.

**Cause**:

grooveASSIGN analyzes git blame for every changed file. Large PRs or high PR volume can consume API quota.

**Solutions**:

1. **Increase rate limit**: GitHub Apps get higher limits on paid plans
2. **Reduce scope**: Only enable for important repositories
3. **Optimize config**: Exclude files that don't need expert review:
   ```yaml
   exclude_patterns:
     - "docs/*"
     - "*.md"
     - "tests/fixtures/*"
   ```

## Integration Issues

### Conflicts with CODEOWNERS

**Problem**: GitHub automatically assigns from CODEOWNERS, grooveASSIGN then replaces them.

**Solution**:

Choose one approach:

**Option 1: Use grooveASSIGN only**
- Remove or disable CODEOWNERS
- Let grooveASSIGN handle all assignments

**Option 2: Use CODEOWNERS primarily**
```yaml
prefer_codeowners: true
fallback_to_blame: false
```

**Option 3: Combine both**
```yaml
prefer_codeowners: true
fallback_to_blame: true
reviewers:
  count: 2  # Adds blame-based reviewers to CODEOWNERS
```

### Conflicts with other reviewer bots

**Problem**: Multiple bots assigning different reviewers.

**Solution**:

Disable other reviewer assignment bots:

- GitHub's auto-assignment settings
- Danger/Peril reviewer rules
- Other GitHub Apps

Only one reviewer assignment system should be active per repository.

### reviewGOOSE integration

**Problem**: grooveASSIGN assigned reviewers but reviewGOOSE notifications aren't working.

**Solution**:

Both apps work independently:

- grooveASSIGN: Assigns reviewers at PR creation
- reviewGOOSE: Notifies assigned reviewers to take action

**If notifications failing**:

1. Verify both apps are installed
2. Check reviewGOOSE [troubleshooting](../reviewgoose/troubleshooting.md)
3. Ensure assigned reviewers have GitHub accounts linked to Slack

## Understanding Assignment Algorithm

### How blame analysis works

grooveASSIGN:

1. Gets list of changed files from PR
2. For each file, runs `git blame` on changed line ranges
3. Counts lines per author (weighted by commit recency)
4. Applies filters (timezone, team, availability)
5. Ranks authors by expertise score
6. Assigns top N reviewers

### Why blame instead of CODEOWNERS?

**CODEOWNERS**: Who *should* review (organizational policy)
**Blame**: Who *actually knows* the code (practical expertise)

**Example**:

```
// File: src/auth.ts
// CODEOWNERS: @security-team (5 people)
// Blame: Alice (80%), Bob (15%), Carol (5%)
```

grooveASSIGN assigns Alice and Bob - they wrote most of the code and can review fastest.

### Recency weighting

Recent commits count more than old ones:

- Commits in last 30 days: 100% weight
- Commits 30-90 days ago: 50% weight
- Commits >90 days ago: 25% weight

This ensures the *current* expert gets assigned, not the original author from 3 years ago.

## Still Having Issues?

If your problem isn't listed here:

1. Check [GitHub Discussions](https://github.com/codegroove/grooveassign/discussions)
2. Review [Configuration Reference](configuration.md)
3. [Contact Support](https://codegroove.dev/support)

Include:

- PR URL if relevant
- `.grooveassign.yml` contents
- Expected vs actual reviewer assignment
- Repository size and activity level
