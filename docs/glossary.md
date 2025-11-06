# Glossary

This glossary defines technical terms used throughout the Ready-to-Review documentation. Terms are organized alphabetically.

---

## A

### API (Application Programming Interface)

A set of rules and protocols that allow different software applications to communicate with each other. Ready-to-Review uses the GitHub API to fetch pull request data and the Slack API to send notifications.

**Example**: When you create a pull request, GitHub's API notifies Ready-to-Review, which then uses Slack's API to post a message.

### Auto-Discovery

A feature where Slack channels are automatically matched to repositories based on identical names. If a repository is named `api-server` and a Slack channel named `#api-server` exists, PR notifications are automatically posted there.

**See also**: [Slack Integration - Channel Auto-Discovery](slack.md#channel-auto-discovery)

---

## B

### Bot

An automated account that performs tasks without human intervention. Examples include `dependabot` (dependency updates), `renovate` (dependency management), and the Ready-to-Review reviewer assignment bot.

**See also**: [GitHub Reviewer Bot](github-bot.md)

### Branch

A parallel version of a repository's code. Developers create branches to work on features or fixes without affecting the main codebase. Pull requests propose merging a branch back into the main branch.

**Example**: You create a branch named `fix-login-bug`, make changes, then create a pull request to merge it into `main`.

---

## C

### CI (Continuous Integration)

Automated testing and building of code whenever changes are pushed. Common CI systems include GitHub Actions, CircleCI, and Jenkins. Ready-to-Review tracks CI status to determine if PRs are ready for review.

**Example**: When you push code, GitHub Actions runs tests. If tests fail, Ready-to-Review marks the PR as "Author: Fix CI".

### Code Ownership

The concept of who is responsible for a section of code, typically determined by who last modified it or who contributes to it most frequently. Ready-to-Review uses Git history to calculate code ownership.

**See also**: [GitHub Reviewer Bot - Code Ownership Detection](github-bot.md#code-ownership-detection)

### Commit

A saved change to a repository. Each commit has a unique ID, message, author, and timestamp. Multiple commits are typically included in a pull request.

**Example**: `git commit -m "Fix authentication bug"` creates a commit with the message "Fix authentication bug".

---

## D

### Dashboard

The web-based interface at `<org>.ready-to-review.dev` that displays all pull requests for your organization, categorized as Incoming, Outgoing, or Drafts.

**See also**: [Dashboard](dashboard.md)

### Direct Message (DM)

A private message sent to an individual user in Slack. Ready-to-Review sends DMs when a user needs to take action on a pull request.

**See also**: [Slack Integration - Notification Timing](slack.md#notification-timing--logic)

### Draft PR

A pull request marked as "draft" or "work in progress". Draft PRs are visible but not ready for review. Reviewers are not assigned until the PR is marked ready.

**Example**: You create a draft PR to share early progress with your team, then mark it ready for review when complete.

---

## F

### Fine-Grained Personal Access Token

A GitHub authentication token with granular permissions, allowing you to specify exactly which repositories and actions the token can access. More secure than classic tokens.

**See also**: [Goose - Using a Fine-Grained Access Token](goose.md#using-a-fine-grained-access-token)

---

## G

### Git

A version control system that tracks changes to files over time. GitHub is built on Git. Commands like `git commit`, `git push`, and `git blame` are Git operations.

### Git Blame

A Git command that shows who last modified each line of a file. Ready-to-Review uses `git blame` to determine code ownership for reviewer assignment.

**Example**: `git blame api/auth.go` shows who wrote each line in `auth.go`.

### GitHub Actions

GitHub's built-in continuous integration and deployment system. Automates testing, building, and deploying code when events occur (like pushing commits or creating PRs).

**Example**: When you create a PR, GitHub Actions runs automated tests to verify the code works.

### GitHub App

An application that integrates with GitHub using OAuth authentication and has specific permissions. Ready-to-Review is a GitHub App that tracks pull requests and assigns reviewers.

**See also**: [Getting Started - Install the GitHub App](getting-started.md#step-1-install-the-github-app)

### GitHub CLI (`gh`)

GitHub's official command-line tool for interacting with GitHub. Used by Goose for authentication.

**Example**: `gh auth login` logs you into GitHub from the command line.

### Goose

Ready-to-Review's desktop application that provides native notifications on macOS, Linux, Windows, and BSD. Named for the goose sounds it makes when you're blocking someone's PR.

**See also**: [Goose Desktop App](goose.md)

---

## M

### Merge

The action of combining changes from one branch into another. When a pull request is approved, it's merged into the target branch (usually `main`).

**Example**: After your PR is approved, it's merged into `main`, and your changes become part of the primary codebase.

### Merge Conflict

A situation where Git cannot automatically merge changes because two branches modified the same lines of code differently. The author must manually resolve conflicts.

**Example**: You and a colleague both edited line 42 of `auth.go` differently. Git can't decide which change to keep, so you must resolve the conflict manually.

### Multi-Tenant

An architecture where multiple organizations share the same infrastructure. Grass Roots and Super-fan plans use multi-tenant infrastructure. Main Stage and Funk Master plans use isolated instances.

---

## O

### OAuth

An authentication standard that allows applications to access your account without seeing your password. GitHub and Slack use OAuth for third-party integrations.

**Example**: When you click "Login with GitHub", you're using OAuth to grant Ready-to-Review access to your GitHub account.

### Organization (GitHub)

A shared GitHub account where teams collaborate on repositories. Organizations have members, teams, and repositories.

**Example**: `github.com/mycompany` is an organization. `github.com/mycompany/api-server` is a repository in that organization.

---

## P

### PR (Pull Request)

A request to merge code changes from one branch into another. Pull requests include a description, changed files, commits, reviews, and CI status.

**Synonyms**: Merge request (in GitLab)

**Example**: You create a PR to merge your `fix-login-bug` branch into `main`.

### PR Metadata

Information about a pull request that doesn't include the actual code changes. Includes title, author, reviewers, status, timestamps, and comments.

**What Ready-to-Review accesses**: PR metadata only (never code contents)

---

## R

### Repository (Repo)

A project that contains code, files, and Git history. Repositories can be public (anyone can see) or private (restricted access).

**Example**: `github.com/codeGROOVE-dev/goose` is a repository.

### Reviewer

A person assigned to review code changes in a pull request. Reviewers can approve, request changes, or comment without approving.

**See also**: [GitHub Reviewer Bot](github-bot.md)

### Reviewer Workload

The number of open pull requests currently assigned to a reviewer. Ready-to-Review tracks workload to avoid overloading reviewers (default threshold: 9 open PRs).

**See also**: [GitHub Reviewer Bot - Workload Balancing](github-bot.md#workload-balancing)

---

## S

### Scope (OAuth)

A permission that defines what an application can access in your account. For example, the `repo:read` scope allows reading repository data.

**Example**: The Ready-to-Review GitHub App requests `pull_requests:read` scope to view PR information.

### Slash Command

A command in Slack that starts with `/`. Ready-to-Review provides `/r2r dashboard` and `/r2r help` commands.

**Example**: Type `/r2r dashboard` in Slack to open your PR dashboard.

### Stale PR

A pull request that hasn't been updated recently. Ready-to-Review considers PRs stale if they haven't been updated in 90 days. Stale PRs don't count toward reviewer workload.

**Example**: A PR last updated 6 months ago is considered stale.

### State Machine

A system that tracks different states and transitions between them. Ready-to-Review uses a state machine to track PR states (e.g., "Author: Fix CI", "Reviewer: Initial Review", "Waiting: Approved").

**See also**: [Core Concepts - Turn-Based PR Tracking](concepts.md#turn-based-pr-tracking)

---

## T

### Token

An authentication credential used to access APIs without a password. GitHub and Slack use tokens for API access.

**Types**:

- **Personal Access Token**: User-created GitHub token
- **OAuth Token**: Token generated during OAuth authentication
- **Bot Token**: Token used by Slack bots

**Security note**: Tokens should be kept secret like passwords.

### Turn-Based Tracking

Ready-to-Review's approach to PR management where, at any moment, one person (or automated system) is responsible for the next action. Eliminates ambiguity about whose turn it is.

**See also**: [Core Concepts - Turn-Based PR Tracking](concepts.md#turn-based-pr-tracking)

---

## W

### Webhook

An automated notification sent from one application to another when an event occurs. GitHub sends webhooks to Ready-to-Review when PRs are created, updated, or closed.

**Example**: When you create a PR, GitHub sends a webhook to Ready-to-Review saying "New PR created". Ready-to-Review then assigns reviewers.

### Workspace (Slack)

A Slack instance for a team or organization. Each workspace has its own URL like `mycompany.slack.com`.

**Example**: Your company's Slack workspace is `acme-corp.slack.com`.

---

## Y

### YAML

A human-readable data format used for configuration files. Ready-to-Review uses YAML for Slack channel mapping configuration (`.codeGROOVE/slack.yaml`).

**Important**: YAML is whitespace-sensitive - use spaces, not tabs, for indentation.

**Example**:

```yaml
global:
    slack: myworkspace.slack.com

channels:
    engineering:
        repos:
            - api-server
```

---

## Numbers & Symbols

### .codeGROOVE

A directory in your repository root that contains Ready-to-Review configuration files. Currently used for `slack.yaml`.

**Example**: `.codeGROOVE/slack.yaml` configures Slack channel mappings.

**Note**: The leading dot (`.`) makes it a hidden directory on Unix systems.

---

## Acronyms

Quick reference for common acronyms:

| Acronym | Full Term | Definition |
|---------|-----------|------------|
| **API** | Application Programming Interface | Protocol for software communication |
| **BAA** | Business Associate Agreement | HIPAA compliance contract |
| **CI** | Continuous Integration | Automated testing and building |
| **CSRF** | Cross-Site Request Forgery | Security attack type |
| **DM** | Direct Message | Private Slack message |
| **DPA** | Data Processing Agreement | GDPR compliance contract |
| **GDPR** | General Data Protection Regulation | EU privacy law |
| **JWT** | JSON Web Token | Authentication token format |
| **OAuth** | Open Authorization | Authentication protocol |
| **PR** | Pull Request | Code review request |
| **SaaS** | Software as a Service | Cloud-hosted software |
| **SOC 2** | Service Organization Control 2 | Security audit standard |
| **TLS** | Transport Layer Security | Encryption protocol |
| **YAML** | YAML Ain't Markup Language | Configuration file format |

---

## Need More Help?

- **General documentation**: Start with [Overview](index.md)
- **Getting started**: See [Getting Started](getting-started.md)
- **Troubleshooting**: Check [Troubleshooting Guide](troubleshooting.md)
- **Support**: Open an issue in the [support repository](https://github.com/codeGROOVE-dev/support)
