# API Reference

Complete API documentation for gitIDENTITY timezone detection and geolocation.

## Base URL

```
https://finder.github.codegroove.app/api/v1
```

All endpoints use `POST` with JSON request bodies.

---

## Detect Timezone

Detect timezone and location for a GitHub user based on activity patterns.

### Endpoint

```http
POST /detect
```

### Request

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | Yes | GitHub username to analyze |
| `cached` | boolean | No | Accept cached result (faster, may be stale) |

#### Example

=== "cURL"
    ```bash
    curl -X POST https://finder.github.codegroove.app/api/v1/detect \
      -H "Content-Type: application/json" \
      -d '{"username": "torvalds"}'
    ```

=== "Python"
    ```python
    import requests

    response = requests.post(
        "https://finder.github.codegroove.app/api/v1/detect",
        json={"username": "torvalds"}
    )
    result = response.json()
    print(f"Timezone: {result['timezone']}")
    print(f"Confidence: {result['confidence']}")
    ```

=== "JavaScript"
    ```javascript
    const response = await fetch(
      'https://finder.github.codegroove.app/api/v1/detect',
      {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({username: 'torvalds'})
      }
    );
    const result = await response.json();
    console.log(`Timezone: ${result.timezone}`);
    ```

=== "Go"
    ```go
    package main

    import (
        "bytes"
        "encoding/json"
        "net/http"
    )

    type DetectRequest struct {
        Username string `json:"username"`
    }

    type DetectResponse struct {
        Username     string  `json:"username"`
        Timezone     string  `json:"timezone"`
        Confidence   float64 `json:"confidence"`
        CountryCode  string  `json:"country_code"`
        LocationName string  `json:"location_name"`
    }

    func detectTimezone(username string) (*DetectResponse, error) {
        body, _ := json.Marshal(DetectRequest{Username: username})
        resp, err := http.Post(
            "https://finder.github.codegroove.app/api/v1/detect",
            "application/json",
            bytes.NewBuffer(body),
        )
        if err != nil {
            return nil, err
        }
        defer resp.Body.Close()

        var result DetectResponse
        json.NewDecoder(resp.Body).Decode(&result)
        return &result, nil
    }
    ```

### Response

#### Success Response (200 OK)

```json
{
  "username": "torvalds",
  "timezone": "America/Los_Angeles",
  "confidence": 0.87,
  "country_code": "US",
  "location_name": "Portland, OR",
  "utc_offset": "-08:00",
  "signals": {
    "commit_count": 15234,
    "activity_span_days": 892,
    "evening_pattern": true,
    "lunch_detected": true
  },
  "cached": false,
  "cached_at": null
}
```

#### Response Fields

| Field | Type | Always Present | Description |
|-------|------|----------------|-------------|
| `username` | string | Yes | GitHub username (as requested) |
| `timezone` | string | Yes | IANA timezone identifier |
| `confidence` | number | Yes | Confidence score (0.0 - 1.0) |
| `country_code` | string | Yes | ISO 3166-1 alpha-2 country code |
| `location_name` | string | No | Human-readable location (city/region) |
| `utc_offset` | string | Yes | UTC offset at time of analysis |
| `signals` | object | No | Detection signals (see below) |
| `cached` | boolean | Yes | Whether result was from cache |
| `cached_at` | string | No | ISO 8601 timestamp of cache creation |

#### Signals Object

When `signals` is present, it contains detection metadata:

| Field | Type | Description |
|-------|------|-------------|
| `commit_count` | number | Total commits analyzed |
| `activity_span_days` | number | Days between first and last commit |
| `evening_pattern` | boolean | Strong evening coding pattern detected |
| `lunch_detected` | boolean | Lunch break detected (11am-2:30pm) |

#### Confidence Interpretation

| Range | Interpretation | Action |
|-------|----------------|---------|
| 0.8 - 1.0 | High confidence | Trust result |
| 0.5 - 0.8 | Moderate confidence | Use with caution |
| 0.3 - 0.5 | Low confidence | Verify with other sources |
| < 0.3 | Too uncertain | API returns 500 instead |

---

## Error Responses

All errors return JSON with `error` and `message` fields.

### 400 - Bad Request

Invalid request parameters.

```json
{
  "error": "invalid_request",
  "message": "username is required"
}
```

**Causes**:

- Missing `username` field
- Empty username
- Invalid JSON syntax

### 404 - User Not Found

GitHub user does not exist or has no public activity.

```json
{
  "error": "user_not_found",
  "message": "GitHub user 'nonexistent' not found"
}
```

**Causes**:

- Username doesn't exist on GitHub
- Account was deleted/suspended
- Account has zero public activity
- Account is completely private

### 429 - Rate Limited

Rate limit exceeded.

```json
{
  "error": "rate_limited",
  "message": "Rate limit exceeded",
  "retry_after": 3600,
  "limit": 100,
  "remaining": 0,
  "reset_at": "2025-01-16T17:00:00Z"
}
```

#### Response Headers

Rate limit information is also in headers:

```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1705424400
Retry-After: 3600
```

#### Rate Limit Fields

| Field | Type | Description |
|-------|------|-------------|
| `retry_after` | number | Seconds until retry allowed |
| `limit` | number | Total requests allowed per window |
| `remaining` | number | Requests remaining in current window |
| `reset_at` | string | ISO 8601 timestamp when limit resets |

### 500 - Detection Failed

Could not determine timezone with sufficient confidence.

```json
{
  "error": "detection_failed",
  "message": "Insufficient activity data for timezone detection",
  "details": {
    "commit_count": 3,
    "min_required": 50,
    "confidence": 0.12
  }
}
```

**Causes**:

- Insufficient public commits (< 50)
- No clear activity patterns
- Conflicting signals (VPN, travel, multiple locations)
- Bot/automated account
- Confidence score < 0.3

### 503 - Service Unavailable

Temporary service disruption.

```json
{
  "error": "service_unavailable",
  "message": "Temporarily unable to process request"
}
```

**Causes**:

- GitHub API outage
- Database maintenance
- System overload

**Action**: Retry with exponential backoff.

---

## Rate Limits

### Free Tier

- **Limit**: 100 requests per hour per IP address
- **Burst**: 10 requests per minute
- **Authentication**: None required

### Authenticated

Contact [recon@codegroove.dev](mailto:recon@codegroove.dev) for API key.

- **Limit**: 1,000 requests per hour
- **Burst**: 50 requests per minute
- **Authentication**: `Authorization: Bearer YOUR_API_KEY`

### Enterprise

Custom rate limits available. Contact for details.

---

## Caching

Results are cached for 90 days to improve performance and reduce GitHub API usage.

### Cache Behavior

- First request: Analyzes GitHub data (slow, 5-30 seconds)
- Subsequent requests: Returns cached result (fast, <100ms)
- Cache updates every 90 days or on explicit request

### Force Refresh

To bypass cache and force fresh analysis:

```bash
curl -X POST https://finder.github.codegroove.app/api/v1/detect \
  -d '{"username": "torvalds", "cached": false}'
```

!!! warning
    Forced refresh counts against rate limit and takes longer. Only use when timezone may have changed (user relocated, changed schedule).

---

## Best Practices

### Error Handling

Always handle all error status codes:

```python
import requests
import time

def detect_with_retry(username, max_retries=3):
    for attempt in range(max_retries):
        try:
            response = requests.post(
                "https://finder.github.codegroove.app/api/v1/detect",
                json={"username": username},
                timeout=60
            )

            if response.status_code == 200:
                return response.json()

            elif response.status_code == 404:
                # User doesn't exist, don't retry
                return None

            elif response.status_code == 429:
                # Rate limited, wait and retry
                retry_after = int(response.headers.get('Retry-After', 60))
                time.sleep(retry_after)
                continue

            elif response.status_code == 500:
                # Detection failed, user has insufficient data
                return None

            elif response.status_code == 503:
                # Service unavailable, retry with backoff
                time.sleep(2 ** attempt)
                continue

        except requests.exceptions.Timeout:
            # Timeout, retry with backoff
            time.sleep(2 ** attempt)
            continue

    return None  # Failed after retries
```

### Performance

For bulk processing:

1. **Cache aggressively**: Results rarely change
2. **Parallelize**: Process multiple users concurrently
3. **Use batch endpoint**: Enterprise only, contact for access
4. **Accept cached results**: Use `cached: true` for instant responses

### Security

- **Don't expose API calls client-side**: Rate limits apply per IP
- **Validate usernames**: Sanitize input before calling API
- **Cache results**: Don't re-query for same user
- **Handle sensitive data**: Timezone data may reveal personal information

---

## Webhooks

Enterprise customers can receive webhooks when:

- Detection completes for queued users
- Cached result expires
- User activity patterns change significantly

Contact [recon@codegroove.dev](mailto:recon@codegroove.dev) for webhook configuration.

---

## Enterprise Features

Contact [recon@codegroove.dev](mailto:recon@codegroove.dev) for:

- **Batch endpoint**: Process 1000+ users in single request
- **Watchlist screening**: OFAC, BIS, UN/EU sanctions integration
- **Custom rate limits**: Higher throughput for large deployments
- **On-premise deployment**: Run gitIDENTITY behind your firewall
- **Webhooks**: Real-time notifications
- **SLA**: Guaranteed uptime and support

---

## Support

- Questions: [GitHub Discussions](https://github.com/codegroove/gitidentity/discussions)
- Issues: See [Troubleshooting](troubleshooting.md)
- Enterprise: [recon@codegroove.dev](mailto:recon@codegroove.dev)
