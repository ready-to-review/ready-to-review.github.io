**What this enables:** Native desktop notifications when PRs need your attention. Works on macOS, Windows, and Linux.

**Security:** reviewGOOSE:Desktop runs on your machine using your GitHub credentials. It communicates with GitHub's API and reviewGOOSE's Turn API for PR state analysis.

### Installation Methods

=== "macOS (Homebrew)"

    **Recommended method for macOS users:**

    ```bash
    # Install reviewGOOSE
    brew install --cask codegroove-dev/tap/reviewgoose

    # Authenticate with GitHub
    gh auth status || gh auth login
    ```

    **Launch:** Open `/Applications/reviewGOOSE.app`

    **Auto-start:** Click menu bar icon → **Start at Login**

=== "Linux (Homebrew)"

    **For Linux distributions with Homebrew** (e.g., [Bluefin](https://projectbluefin.io/)):

    ```bash
    # Install reviewGOOSE
    brew install codegroove-dev/tap/reviewgoose

    # Authenticate with GitHub
    gh auth status || gh auth login
    ```

    reviewGOOSE will be available in your applications menu.

=== "Linux (Package Manager)"

    **For traditional Linux distributions:**

    ```bash
    # Install dependencies
    # Debian/Ubuntu:
    sudo apt install golang-go gh

    # Fedora:
    sudo dnf install golang gh

    # Arch Linux:
    sudo pacman -S go github-cli

    # Authenticate with GitHub
    gh auth login

    # Install reviewGOOSE
    go install github.com/codeGROOVE-dev/goose/cmd/reviewgoose@latest
    ```

    Binary installed to `~/go/bin/reviewgoose`. Add to auto-start for persistent notifications.

=== "BSD"

    ```bash
    # Install dependencies (FreeBSD)
    pkg install go gh git

    # Authenticate with GitHub
    gh auth login

    # Install reviewGOOSE
    go install github.com/codeGROOVE-dev/goose/cmd/reviewgoose@latest
    ```

    Binary installed to `~/go/bin/reviewgoose`.

=== "Windows"

    **Prerequisites:** Install [Go 1.23.4+](https://go.dev/dl/) and [GitHub CLI](https://cli.github.com/)

    ```powershell
    # Authenticate with GitHub
    gh auth login

    # Install reviewGOOSE
    go install github.com/codeGROOVE-dev/goose/cmd/reviewgoose@latest
    ```

    Binary installed to `%USERPROFILE%\go\bin\reviewgoose.exe`. Add to startup for persistent notifications.

=== "Build from Source"

    **For developers or custom builds:**

    ```bash
    # Clone the repository
    git clone https://github.com/codeGROOVE-dev/goose.git
    cd goose

    # Build and run
    make run
    ```

    **macOS:** Click menu bar icon → **Start at Login** for auto-launch.

--8<-- "docs/.snippets/goose-credentials.md"

### Verify It Works

Create a test PR in a repository where the GitHub App is installed. You should receive a desktop notification within seconds.
