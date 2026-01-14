# API Reference

gitIDENTITY JSON API for detecting GitHub user locations.

## Endpoint

```
POST https://finder.github.codegroove.app/api/v1/detect
```

## Request

```json
{
  "username": "torvalds"
}
```

## Response

```json
{
  "username": "torvalds",
  "timezone": "America/Los_Angeles",
  "confidence": 0.87,
  "country_code": "US",
  "location_name": "Portland, OR"
}
```

## Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `username` | string | GitHub username |
| `timezone` | string | IANA timezone |
| `confidence` | number | 0.0 - 1.0 |
| `country_code` | string | ISO country code |
| `location_name` | string | Human-readable location |

## Errors

**404 - User Not Found**
```json
{"error": "user_not_found", "message": "GitHub user not found"}
```

**429 - Rate Limited**
```json
{"error": "rate_limited", "retry_after": 3600}
```

**500 - Detection Failed**
```json
{"error": "detection_failed", "message": "Could not determine timezone"}
```

## Enterprise

For bulk screening, watchlist integration, or on-premise deployment, contact [recon@codegroove.dev](mailto:recon@codegroove.dev).
