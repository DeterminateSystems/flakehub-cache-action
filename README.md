# FlakeHub Cache Action

Use FlakeHub Cache, zero-configuration binary cache for Nix on GitHub Actions.

Add our [GitHub Action][action] after installing Nix, in your workflow, like this:

```yaml
- uses: DeterminateSystems/flakehub-cache-action@main
```

See [Usage](#usage) for a detailed example.

## Why use FlakeHub Cache?

- Automatic, authenticated integration with GitHub Actions
- Cached paths are available on developer and target machines
- Fully managed by Determinate Systems

## Usage

Add it to your Linux and macOS GitHub Actions workflows, like this:

```yaml
name: CI

on:
  push:
  pull_request:

jobs:
  check:
    runs-on: ubuntu-22.04
    permissions:
      id-token: "write"
      contents: "read"
    steps:
      - uses: actions/checkout@v4
      - uses: DeterminateSystems/nix-installer-action@main
      - uses: DeterminateSystems/flakehub-cache-action@main
      - uses: DeterminateSystems/flake-checker-action@main
      - name: Run `nix build`
        run: nix build .
```

That's it.
Everything built in your workflow will be cached.

## Action Options

<!--
cat action.yml| nix run nixpkgs#yq-go -- '[[ "Parameter", "Description", "Required", "Default" ], ["-", "-", "-", "-"]] + [.inputs | to_entries | sort_by(.key) | .[] | ["`" + .key + "`", .value.description, .value.required // "", .value.default // ""]] | map(join(" | ")) | .[] | "| " + . + " |"' -r
-->

| Parameter                   | Description                                                                                                     | Required | Default                    |
| --------------------------- | --------------------------------------------------------------------------------------------------------------- | -------- | -------------------------- |
| `diagnostic-endpoint`       | Diagnostic endpoint url where diagnostics and performance data is sent. To disable set this to an empty string. |          | -                          |
| `diff-store`                | Whether or not to diff the store before and after Magic Nix Cache runs                                          |          |                            |
| `flakehub-api-server`       | The FlakeHub API server.                                                                                        |          | https://api.flakehub.com   |
| `flakehub-cache-server`     | The FlakeHub binary cache server.                                                                               |          | https://cache.flakehub.com |
| `flakehub-flake-name`       | The name of your flake on FlakeHub. The empty string will autodetect your FlakeHub flake.                       |          |                            |
| `listen`                    | The host and port to listen on.                                                                                 |          | 127.0.0.1:37515            |
| `source-binary`             | Run a version of the cache binary from somewhere already on disk. Conflicts with all other `source-*` options.  |          |                            |
| `source-branch`             | The branch of `magic-nix-cache` to use. Conflicts with all other `source-*` options.                            |          |                            |
| `source-pr`                 | The PR of `magic-nix-cache` to use. Conflicts with all other `source-*` options.                                |          |                            |
| `source-revision`           | The revision of `nix-magic-nix-cache` to use. Conflicts with all other `source-*` options.                      |          |                            |
| `source-tag`                | The tag of `magic-nix-cache` to use. Conflicts with all other `source-*` options.                               |          |                            |
| `source-url`                | A URL pointing to a `magic-nix-cache` binary. Overrides all other `source-*` options.                           |          |                            |
| `startup-notification-port` | The port magic-nix-cache uses for daemon startup notification.                                                  |          | 41239                      |

[detsys]: https://determinate.systems/
[action]: https://github.com/DeterminateSystems/flakehub-cache-action/
[installer]: https://github.com/DeterminateSystems/nix-installer/
[privacy]: https://determinate.systems/policies/privacy
[telemetry]: https://github.com/DeterminateSystems/magic-nix-cache/blob/main/magic-nix-cache/src/telemetry.rs
[z2ncache]: https://zero-to-nix.com/concepts/caching#binary-caches
[zhaofeng]: https://github.com/zhaofengli/
[z2n]: https://zero-to-nix.com
