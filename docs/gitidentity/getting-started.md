# Getting Started with gitIDENTITY

Detect GitHub user locations via behavioral analysis.

## Try the Preview

Visit [preview.gitidentity.dev](https://preview.gitidentity.dev/) to analyze any GitHub user.

## API Access

Use the hosted API for integration:

```
POST https://finder.github.codegroove.app/api/v1/detect
```

```json
{
  "username": "torvalds"
}
```

Response:
```json
{
  "username": "torvalds",
  "timezone": "America/Los_Angeles",
  "confidence": 0.87,
  "location": "Portland, OR"
}
```

See [API Reference](api.md) for full documentation.

## Enterprise

For bulk screening, watchlist integration, and on-premise deployment, contact [recon@codegroove.dev](mailto:recon@codegroove.dev).
