!!! tip "Goose Credential Options"
    **Default:** Goose reuses credentials from your local `gh` tool (GitHub CLI).

    **For evaluation:** Generate a GitHub Personal Access Token (PAT) with access to only public repositories:

    1. Create a token: [github.com/settings/personal-access-tokens/new](https://github.com/settings/personal-access-tokens/new)
    2. Grant permissions: **Pull requests** (Read), **Metadata** (Read)
    3. Select **Public Repositories (read-only)** for maximum security during evaluation
    4. Run: `env GITHUB_TOKEN=your_token_here goose`

    This ensures Goose can only access public PRs during your evaluation period.
