#!/bin/sh

set -eux

ACTION_TAG=$1
REPO="DeterminateSystems/magic-nix-cache-action"

default_branch() {
    gh api "repos/$REPO" \
        | jq -r '.default_branch'
}

get_latest_revision() {
    gh api "repos/$1/commits/$(default_branch)" \
        | jq -r '.sha'
}

checkout_tag() {
    gh release list \
        --repo actions/checkout \
        --exclude-drafts \
        --exclude-pre-releases \
        --jq 'map(select(.isLatest)) | first | .tagName' \
        --json isLatest,tagName
}

magic_nix_cache_binary_rev() {
  sha=$(get_latest_revision "DeterminateSystems/magic-nix-cache")

  (
    echo "Checking to see if $sha for magic-nix-cache has binaries yet..."
    for arch in ARM64-macOS X64-macOS X64-Linux ARM64-Linux; do
      curl -LI --fail \
        "https://install.determinate.systems/magic-nix-cache/rev/$sha/$arch"
    done
  ) >&2

  echo "$sha"
}

determinate_nix_action_major() {
    gh release list \
        --repo DeterminateSystems/determinate-nix-action \
        --exclude-drafts \
        --exclude-pre-releases \
        --jq 'map(select(.isLatest)) | first | .tagName' \
        --json isLatest,tagName
}

main() {
    revision=$(get_latest_revision "$REPO")
    checkout_tag=$(checkout_tag)
    mnc_binary_rev=$(magic_nix_cache_binary_rev)

    jq -n '$ARGS.named' \
        --arg upstream_action_revision "$revision" \
        --arg "self_version" "$ACTION_TAG" \
        --arg "binary_revision" "$mnc_binary_rev" \
        --arg "checkout_action_tag" "$checkout_tag" \
        | cat > tools/state.json
}

main
