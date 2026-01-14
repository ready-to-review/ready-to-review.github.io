# reviewGOOSE:Desktop

Native desktop notifications for macOS, Linux, Windows, and BSD.

Honks when you're blocking a PR. Jet sounds when your PR advances.

## Install

=== "macOS"

    ```bash
    brew install --cask codegroove-dev/tap/reviewgoose
    ```

    Launch from `/Applications/reviewGOOSE.app`

=== "Linux (Homebrew)"

    ```bash
    brew install codegroove-dev/tap/reviewgoose
    ```

=== "Linux (Manual)"

    ```bash
    # Install Go and GitHub CLI first
    go install github.com/codeGROOVE-dev/goose/cmd/reviewgoose@latest
    ```

=== "Windows"

    ```powershell
    # Install Go and GitHub CLI first
    go install github.com/codeGROOVE-dev/goose/cmd/reviewgoose@latest
    ```

## Setup

1. Install the [GitHub App](github-bot.md) first
2. Authenticate with GitHub CLI: `gh auth login`
3. Launch the app

## Settings

Click the menu bar icon:

- **Organization Filter**: Show/hide specific orgs
- **Audio**: Enable/disable notification sounds
- **Auto-open**: Open PRs in browser automatically

## Troubleshooting

**No icon**: Check if the app is running. Restart the app.

**No notifications**: Check OS notification permissions. Verify PRs exist by clicking the icon.

**Auth failed**: Run `gh auth status` to check credentials. Re-authenticate with `gh auth login`.
