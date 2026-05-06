<p align="center">
  <a href="https://determinate.systems" target="_blank"><img src="https://raw.githubusercontent.com/determinatesystems/.github/main/.github/banner.jpg"></a>
</p>
<p align="center">
  &nbsp;<a href="https://determinate.systems/discord" target="_blank"><img alt="Discord" src="https://img.shields.io/discord/1116012109709463613?style=for-the-badge&logo=discord&logoColor=%23ffffff&label=Discord&labelColor=%234253e8&color=%23e4e2e2"></a>&nbsp;
  &nbsp;<a href="https://bsky.app/profile/determinate.systems" target="_blank"><img alt="Bluesky" src="https://img.shields.io/badge/Bluesky-0772D8?style=for-the-badge&logo=bluesky&logoColor=%23ffffff"></a>&nbsp;
  &nbsp;<a href="https://hachyderm.io/@determinatesystems" target="_blank"><img alt="Mastodon" src="https://img.shields.io/badge/Mastodon-6468fa?style=for-the-badge&logo=mastodon&logoColor=%23ffffff"></a>&nbsp;
  &nbsp;<a href="https://twitter.com/DeterminateSys" target="_blank"><img alt="Twitter" src="https://img.shields.io/badge/Twitter-303030?style=for-the-badge&logo=x&logoColor=%23ffffff"></a>&nbsp;
  &nbsp;<a href="https://www.linkedin.com/company/determinate-systems" target="_blank"><img alt="LinkedIn" src="https://img.shields.io/badge/LinkedIn-1667be?style=for-the-badge&logo=linkedin&logoColor=%23ffffff"></a>&nbsp;
</p>

# ️❄️ FlakeHub Cache Action

[FlakeHub Cache][cache] is the zero-configuration binary cache for GitHub Actions, workstations, production, and other CI platforms.

FlakeHub Cache is part of [Determinate], the best way to use Nix on macOS, WSL, and Linux.
It is an end-to-end toolchain for using Nix, from installation to collaboration to deployment.

Based on the [Determinate Nix Installer][nix-installer] and its corresponding [Nix Installer Action][nix-installer-action], responsible for over tens of thousands of Nix installs daily.

## 🫶 Platform support

- Automatic, authenticated integration with GitHub Actions
- Cached paths are available on developer and target machines
- Fully managed by Determinate Systems
- 🐧 Linux, x86_64, aarch64
- 🍏 macOS (Apple Silicon)
- 🪟 WSL2, x86_64 and aarch64
- 🐋 Containers, ARC, and Act
- 🐙 GitHub Enterprise Server
- 💁 GitHub Hosted, self-hosted, and long running Actions Runners

## ️🔧 Usage

Here's an example Actions workflow configuration that uses `flakehub-cache-action`:

```yaml
name: CI

on:
  pull_request:
  push:
    branches: [main]

jobs:
  check:
    runs-on: ubuntu-latest
    permissions:
      id-token: "write"
      contents: "read"
    steps:
      - uses: actions/checkout@<!-- checkout_action_tag -->
      - uses: DeterminateSystems/determinate-nix-action@v3
      - uses: DeterminateSystems/flakehub-cache-action@<!-- version_major --> # or <!-- version_minor --> to pin to a release
      - run: nix build .
```

> [!IMPORTANT]
> You must add a `permissions` block like the one in the example above or else Determinate Nix can't authenticate with FlakeHub or [FlakeHub Cache][cache].

## 📌 Version pinning: lock it down

### Why pin your Action?

Unlike `DeterminateSystems/magic-nix-cache-action`, we fully support explicit version pinning for maximum consistency.
This Action is **automatically tagged** for every release, giving you complete control over your CI environment:

📍 Pinning to `DeterminateSystems/flakehub-cache-action@<!-- version_minor -->` guarantees:

- Same `flakehub-cache-action` revision every time
- Reproducible CI workflows, even years later

✨ Using `@main` instead? You'll:

- Always get the latest FlakeHub Cache release
- Occasionally participate in phased rollouts (helping us test new releases!)

> [!IMPORTANT]
> Set up [Dependabot] to stay current with FlakeHub Cache releases without sacrificing stability.

### 🤖 Automate updates with Dependabot

Keep your GitHub Actions fresh without manual work! Create `.github/dependabot.yml` with:

```yaml
version: 2
updates:
  - package-ecosystem: github-actions
    directory: /
    schedule:
      interval: weekly
```

## ️⚙️ Configuration

<!-- table -->

### Debugging mode

If you're having issues pushing to FlakeHub Cache and would like deeper insight into potential causes, we recommend enabling verbose logging by setting one of these [environment variables][gha-env-vars] to either `1` or `true`:

- `RUNNER_DEBUG`
- `ACTIONS_STEP_DEBUG`
- `ACTIONS_RUNNER_DEBUG`

GitHub Actions generates a ZIP archive of the workflow's logs that you can download by clicking **Download log archive** in the dropdown menu for that run.
If you set one of these environment variables, the archive includes the verbose logs.

You can set these variables either in your workflow YAML configuration in `.github/workflows` or as a repository-wide secret or environment variable.

Here's an example of enabling debugging mode in a workflow configuration:

```yaml
steps:
  - name: Push to FlakeHub Cache
    env:
      RUNNER_DEBUG: 1
    uses: DeterminateSystems/flakehub-cache-action@<!-- version_major -->
```

## 🛟 Need help? We're here for you

We're committed to making your experience with Determinate Nix and FlakeHub as smooth as possible. If you encounter any issues or have questions, here's how to reach us:

- 🐛 **Found a bug?** [Open an issue](https://github.com/DeterminateSystems/determinate-nix-action/issues/new) on GitHub
- 💬 **Want to chat?** Join our [Discord community](https://determinate.systems/discord) for quick help and discussions
- 📧 **Need direct support?** Email us at [support@determinate.systems](mailto:support@determinate.systems)

🤝 **Looking for enterprise support?** We offer dedicated support contracts and shared Slack channels for organizations requiring priority assistance. [Contact us](mailto:support@determinate.systems) to learn more.

[cache]: https://flakehub.com/cache
[dependabot]: https://github.com/dependabot
[determinate]: https://docs.determinate.systems
[gha-env-vars]: https://docs.github.com/en/actions/reference/workflows-and-actions/variables#default-environment-variables
[nix-installer-action]: https://github.com/DeterminateSystems/nix-installer-action
[nix-installer]: https://github.com/DeterminateSystems/nix-installer
