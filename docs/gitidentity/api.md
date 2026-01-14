# API Reference

gitIDENTITY provides a JSON API for integration.

## Hosted Instance

```
https://finder.github.codegroove.app
```

## Self-Hosted

Start the server:

```bash
locator-server --port 8080
```

## Endpoints

### Detect User

Detect a GitHub user's timezone.

```
POST /api/v1/detect
```

**Request:**

```json
{
  "username": "torvalds"
}
```

**Response:**

```json
{
  "username": "torvalds",
  "timezone": "America/Los_Angeles",
  "utc_offset": -8,
  "confidence": 0.87,
  "country_code": "US",
  "location": "Portland, OR",
  "detection_methods": [
    "activity_pattern",
    "geocoded_location",
    "evening_activity"
  ],
  "cached": false,
  "cached_at": null
}
```

**Response Fields:**

| Field | Type | Description |
|-------|------|-------------|
| `username` | string | GitHub username |
| `timezone` | string | IANA timezone (e.g., `America/Los_Angeles`) |
| `utc_offset` | number | UTC offset in hours |
| `confidence` | number | Confidence score (0.0 - 1.0) |
| `country_code` | string | ISO country code |
| `location` | string | Human-readable location |
| `detection_methods` | array | Methods that contributed to detection |
| `cached` | boolean | Whether result came from cache |
| `cached_at` | string | Cache timestamp (ISO 8601) |

### Health Check

```
GET /health
```

**Response:**

```json
{
  "status": "ok"
}
```

## Error Responses

**User Not Found (404):**

```json
{
  "error": "user_not_found",
  "message": "GitHub user 'invalid' not found"
}
```

**Rate Limited (429):**

```json
{
  "error": "rate_limited",
  "message": "GitHub API rate limit exceeded",
  "retry_after": 3600
}
```

**Detection Failed (500):**

```json
{
  "error": "detection_failed",
  "message": "Could not determine timezone with sufficient confidence"
}
```

## Go Library

Use gitIDENTITY programmatically:

```go
import "github.com/codeGROOVE-dev/locator/pkg/locator"

detector := locator.New(
    ctx,
    locator.WithGitHubToken(token),
    locator.WithGeminiAPIKey(key),
    locator.WithGoogleMapsKey(mapsKey),
)

result, err := detector.Detect(ctx, "octocat")
if err != nil {
    log.Fatal(err)
}

fmt.Printf("%s lives in %s (%.0f%% confidence)\n",
    result.Username,
    result.Timezone,
    result.Confidence*100,
)
```

### Options

```go
locator.New(ctx,
    locator.WithGitHubToken(token),        // GitHub API access
    locator.WithGeminiAPIKey(key),         // AI analysis
    locator.WithGoogleMapsKey(mapsKey),    // Geocoding
    locator.WithCacheDir("/tmp/cache"),    // Custom cache
    locator.WithActivityOnly(true),        // Skip AI
)
```
