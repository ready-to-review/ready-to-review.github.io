# gitIDENTITY

**Developer threat intelligence. Know who you're working with.**

---

## The Problem

DPRK operatives have infiltrated hundreds of Fortune 500 companies via fake contractor identities. Traditional background checks don't catch developers who fabricate their location or identity.

## The Solution

gitIDENTITY detects mismatches between claimed and actual developer location using behavioral analysis of commit patterns.

[Try the Preview →](https://preview.gitidentity.dev/){ .md-button .md-button--primary }

---

## How It Works

We analyze GitHub activity to determine actual timezone:

| Signal | What it reveals |
|--------|-----------------|
| **Sleep cycles** | Inactivity patterns reveal timezone |
| **Evening activity** | Personal coding (7-11pm) is the strongest signal |
| **Lunch breaks** | Gaps between 11am-2:30pm local time |

Then we compare against claimed location and screen against OFAC/BIS watchlists.

---

## Use Cases

- **Technical Hiring** — Verify candidate location claims
- **Supply Chain Security** — Screen contributors before granting commit access
- **Defense & Government** — Meet ITAR and export control requirements

---

## Documentation

- [Getting Started](getting-started.md)
- [API Reference](api.md)

Questions? [recon@codegroove.dev](mailto:recon@codegroove.dev)
