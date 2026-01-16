# Troubleshooting

Common issues and solutions for gitIDENTITY.

## API Usage

### 404 - User Not Found

**Problem**: API returns 404 for a valid GitHub username.

**Possible causes**:

1. **Username typo**: Double-check spelling and case
2. **Account deleted/suspended**: GitHub account no longer exists
3. **Private account**: User has no public activity
4. **Recent account**: Account created <48 hours ago (GitHub API lag)

**Solution**:

Verify username on GitHub:
```bash
curl https://api.github.com/users/USERNAME
```

If GitHub API returns 404, gitIDENTITY will too.

### 500 - Detection Failed

**Problem**: API returns 500 error for valid user.

**Possible causes**:

1. **Insufficient activity data**
   - Account has <10 commits
   - All commits >2 years old
   - No public repositories

2. **Ambiguous patterns**
   - Contributes from multiple locations (VPN, travel)
   - Inconsistent activity times
   - Works across timezones regularly

3. **Bot/service account**
   - Automated commits don't follow human patterns
   - No timezone signal in commit timing

**Solution**:

This is expected for accounts without analyzable patterns. Detection requires:

- At least 50 commits in public repositories
- Activity spanning 4+ weeks
- Consistent timing patterns

!!! note
    Detection confidence <0.3 triggers 500 error rather than returning unreliable data.

### 429 - Rate Limited

**Problem**: API returns 429 after multiple requests.

**Rate limits**:

- **Free tier**: 100 requests/hour per IP
- **Authenticated**: 1000 requests/hour with API key
- **Enterprise**: Custom limits

**Solution**:

1. Check `Retry-After` header for wait time
2. Implement exponential backoff
3. Cache results (timezone rarely changes)
4. Contact [recon@codegroove.dev](mailto:recon@codegroove.dev) for higher limits

**Example retry logic**:

```python
import time
import requests

def detect_timezone(username, max_retries=3):
    for attempt in range(max_retries):
        response = requests.post(
            "https://finder.github.codegroove.app/api/v1/detect",
            json={"username": username}
        )
        if response.status_code == 429:
            retry_after = int(response.headers.get("Retry-After", 60))
            time.sleep(retry_after)
            continue
        return response.json()
```

## Detection Accuracy

### Low confidence score

**Problem**: API returns timezone but `confidence < 0.5`.

**Understanding confidence**:

- **0.8-1.0**: High confidence, strong signal
- **0.5-0.8**: Moderate confidence, reasonable guess
- **0.3-0.5**: Low confidence, best guess from limited data
- **<0.3**: Too uncertain, API returns 500 instead

**Factors reducing confidence**:

- Sparse commit history
- Irregular activity patterns
- VPN/proxy usage
- Recent timezone change (relocation, remote work)
- Multi-timezone collaboration

**When to trust low-confidence results**:

- Use as hint, not fact
- Cross-reference with profile location
- Combine with other signals
- Accept margin of error

### Incorrect timezone detected

**Problem**: gitIDENTITY detects wrong timezone for a user.

**Common causes**:

1. **Recent relocation**
   - Detection based on historical activity
   - Takes 4-8 weeks to update after move

2. **VPN usage**
   - Commit times reflect VPN server location
   - GitHub API sees VPN timezone

3. **Night owl/early bird**
   - Unusual work hours shift detected timezone
   - Example: US developer working 2am-10am appears European

4. **Remote work across timezones**
   - Collaborates with team in different timezone
   - Adjusts schedule to match team

**Verification**:

Compare with:

- GitHub profile location field
- Commit message language/references
- Repository locations (company timezone)
- Social media profiles

**Limitation**:

gitIDENTITY detects *behavior timezone* (when you code), not *stated location* (where you claim to be). These may differ.

### Country mismatch with timezone

**Problem**: Timezone is America/New_York but country_code is CA (Canada).

**Explanation**:

This is correct! Timezones cross borders:

- `America/New_York`: Used in US (New York) and Canada (Toronto)
- `America/Los_Angeles`: Used in US (California) and Canada (Vancouver area)
- `Europe/London`: Used in UK and Portugal (partially)

**Country detection**:

gitIDENTITY detects country from:

1. Timezone (narrows to region)
2. Profile location hints
3. Language in commits/PRs
4. Repository ownership
5. Social media references

If timezone could be multiple countries, confidence drops and country may be ambiguous.

### Profile says one location, detection says another

**Problem**: GitHub profile says "San Francisco" but detection says America/New_York.

**Possible causes**:

1. **Stale profile**: User moved but didn't update profile
2. **Remote work**: Lives in SF, works for NY-based company on NY hours
3. **Marketing/privacy**: Profile location is aspirational or hidden
4. **VPN**: Commits route through East Coast servers

**Which to trust?**:

- **Profile**: Where user *claims* to be
- **gitIDENTITY**: Where user *behaves* like they are

For security screening, behavioral timezone is more reliable than self-reported location.

## Performance

### Slow API responses

**Problem**: Detection takes >10 seconds.

**Causes**:

1. **Large commit history**: Analyzing 10,000+ commits
2. **Many repositories**: User contributes to 100+ repos
3. **Cold cache**: First request for this user
4. **GitHub API rate limits**: Waiting for data from GitHub

**Solutions**:

1. **Cache results**: Timezone rarely changes, cache for 30+ days
2. **Async processing**: Don't block user-facing requests
3. **Batch requests**: Process multiple users in parallel
4. **Accept cached data**: Use `cached: true` parameter (instant response)

**Example**:

```bash
# Accept cached result (fast but may be stale)
curl https://finder.github.codegroove.app/api/v1/detect?cached=true \
  -d '{"username":"octocat"}'
```

### Request timeout

**Problem**: API request times out after 30 seconds.

**Cause**:

Extremely large commit history (>50,000 commits) or GitHub API outage.

**Solution**:

1. Retry with `cached: true` parameter
2. Implement client-side timeout handling
3. Fall back to profile location if available
4. Contact support for problematic usernames

## Security Screening

### False positives on sanctions screening

**Problem**: Developer flagged incorrectly by watchlist check.

**Causes**:

1. **Common name**: Many people share same name
2. **Location inference**: Behavioral timezone doesn't prove physical location
3. **VPN confusion**: Appears to be in sanctioned region via VPN

**Recommendation**:

Use gitIDENTITY as one signal among many:

- ✅ Do: Use as screening trigger for manual review
- ❌ Don't: Auto-reject based solely on gitIDENTITY

Combine with:

- Government ID verification
- Payment method location
- IP address analysis
- Background check services

### Compliance requirements

**Question**: Is gitIDENTITY sufficient for OFAC/BIS compliance?

**Answer**:

No. gitIDENTITY provides *behavioral geolocation* to inform screening decisions, not legal proof of location.

**For compliance**:

1. Use gitIDENTITY to flag potential risks
2. Conduct manual review of flagged accounts
3. Request documentation from contributor
4. Use licensed compliance screening service for final determination

gitIDENTITY helps you know *who to investigate*, not whether to approve/reject.

## Data Privacy

### GDPR compliance

**Question**: Does gitIDENTITY store personal data?

**Answer**:

gitIDENTITY:

- ✅ Analyzes publicly available GitHub data
- ✅ Caches detection results for 90 days
- ❌ Does not collect email, IP address, or identifying info beyond username
- ❌ Does not track individual users across sessions

**Data retention**:

- API response cache: 90 days
- Aggregated statistics: Indefinite (anonymized)
- User profile data: Not stored (queried from GitHub API)

**Right to erasure**:

Contact [privacy@codegroove.dev](mailto:privacy@codegroove.dev) to request cache deletion.

### Consent requirements

**Question**: Do contributors need to consent to timezone detection?

**Answer**:

No. gitIDENTITY only analyzes publicly available data:

- Public commit timestamps
- Public repository contributions
- Public profile information

This is equivalent to manual analysis anyone could perform. No additional consent required beyond GitHub's existing terms.

## API Integration

### Authentication

**Question**: How do I authenticate API requests?

**Answer**:

Free tier: No authentication required (IP-based rate limits)

For higher limits:

1. Contact [recon@codegroove.dev](mailto:recon@codegroove.dev)
2. Receive API key
3. Include in requests:
   ```bash
   curl https://finder.github.codegroove.app/api/v1/detect \
     -H "Authorization: Bearer YOUR_API_KEY" \
     -d '{"username":"octocat"}'
   ```

### Bulk processing

**Question**: How do I screen 1000+ contributors efficiently?

**Answer**:

Use batch endpoint (Enterprise only):

```bash
curl https://finder.github.codegroove.app/api/v1/detect/batch \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{"usernames":["user1","user2","user3"]}'
```

Returns results for all users in single response.

For custom integration, contact [recon@codegroove.dev](mailto:recon@codegroove.dev).

### Webhook notifications

**Question**: Can I get notified when new contributors appear?

**Answer**:

Not currently available via API. Enterprise customers can integrate with GitHub webhooks to detect new contributors and trigger gitIDENTITY screening.

Example flow:

1. GitHub webhook fires on new PR
2. Your service extracts contributor username
3. Call gitIDENTITY API to detect timezone
4. Flag for review if country code matches watchlist

## Still Having Issues?

If your problem isn't listed here:

1. Check [API Reference](api.md) for correct usage
2. Review [GitHub Discussions](https://github.com/codegroove/gitidentity/discussions)
3. Contact [recon@codegroove.dev](mailto:recon@codegroove.dev)

For security/compliance questions, include:

- Use case description
- Volume of requests
- Compliance requirements
- Integration architecture
