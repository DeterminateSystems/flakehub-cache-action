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

FlakeHub Cache is the zero-configuration binary cache for GitHub Actions, workstations, production, and other CI platforms.

FlakeHub Cache is part of [Determinate], the best way to use Nix on macOS, WSL, and Linux.
It is an end-to-end toolchain for using Nix, from installation to collaboration to deployment.

Based on the [Determinate Nix Installer][nix-installer] and its corresponding [Nix Installer Action][nix-installer-action], responsible for over tens of thousands of Nix installs daily.

## 🫶 Platform support

- Automatic, authenticated integration with GitHub Actions
- Cached paths are available on developer and target machines
- Fully managed by Determinate Systems
- 🐧 Linux, x86_64, aarch64
- 🍏 macOS, x86_64 and aarch64
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
      - uses: DeterminateSystems/flakehub-cache-action@v3 # or <!-- version --> to pin to a release
      - run: nix build .
```

> [!IMPORTANT]
> You must add a `permissions` block like the one in the example above or else Determinate Nix can't authenticate with FlakeHub or [FlakeHub Cache][cache].

## 📌 Version pinning: lock it down!

### Why pin your Action?

Unlike `DeterminateSystems/magic-nix-cache-action`, we fully support explicit version pinning for maximum consistency.
This Action is **automatically tagged** for every release, giving you complete control over your CI environment:

📍 Pinning to `DeterminateSystems/flakehub-cache-action@<!-- version -->` guarantees:

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

## 🛟 Need help? We're here for you!

We're committed to making your experience with Determinate Nix and FlakeHub as smooth as possible. If you encounter any issues or have questions, here's how to reach us:

- 🐛 **Found a bug?** [Open an issue](https://github.com/DeterminateSystems/determinate-nix-action/issues/new) on GitHub
- 💬 **Want to chat?** Join our [Discord community](https://determinate.systems/discord) for quick help and discussions
- 📧 **Need direct support?** Email us at [support@determinate.systems](mailto:support@determinate.systems)

🤝 **Looking for enterprise support?** We offer dedicated support contracts and shared Slack channels for organizations requiring priority assistance. [Contact us](mailto:support@determinate.systems) to learn more.

[action]: https://github.com/DeterminateSystems/flakehub-cache-action/
[cache]: https://flakehub.com/cache
[dependabot]: https://github.com/dependabot
[det-nix]: https://docs.determinate.systems/determinate-nix
[determinate]: https://docs.determinate.systems
[detsys]: https://determinate.systems/
[flakehub]: https//flakehub.com
[installer]: https://github.com/DeterminateSystems/nix-installer/
[nix-installer-action]: https://github.com/DeterminateSystems/nix-installer-action
[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[privacy]: https://determinate.systems/policies/privacy
[telemetry]: https://github.com/DeterminateSystems/magic-nix-cache/blob/main/magic-nix-cache/src/telemetry.rs
[z2n]: https://zero-to-nix.com
[z2ncache]: https://zero-to-nix.com/concepts/caching#binary-caches
[zhaofeng]: https://github.com/zhaofengli/
