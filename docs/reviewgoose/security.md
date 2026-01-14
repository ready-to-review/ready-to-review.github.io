# Security

## What We Access

**GitHub:**
- PR metadata (titles, authors, reviewers, status)
- `.codeGROOVE/` config files
- Organization membership

**We do not access:** Source code, commits, comments, issues, secrets.

**Slack:**
- Channel membership (to detect if you saw notifications)
- Email addresses (to match GitHub ↔ Slack accounts)

**Desktop app:** Uses your GitHub CLI credentials locally. No data sent to us.

## Data Storage

| Data | Retention |
|------|-----------|
| PR metadata | 28 days |
| User mappings | 28 days |
| Webhook events | 72 hours |

**Not stored:** Source code, tokens, commit diffs.

**Encryption:** AES-256 at rest, TLS 1.2+ in transit.

## Privacy

- No third-party sharing (except GitHub/Slack APIs you authorize)
- No telemetry or tracking
- Emails hashed, not stored plaintext

## Deletion

Uninstall the GitHub App → data deleted within 48 hours.

## Infrastructure

Google Cloud Platform (Cloud Run, Datastore). Private VPC, no public backend IPs.

## Security Issues

Report vulnerabilities: [github.com/codeGROOVE-dev/support/security](https://github.com/codeGROOVE-dev/support/security)
