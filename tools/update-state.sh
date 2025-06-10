#!/bin/sh

set -eux

MAGIC_NIX_CACHE_TAG=$1
REPO="DeterminateSystems/magic-nix-cache-action"

default_branch() {
    gh api "repos/$REPO" \
        | jq -r '.default_branch'
}

get_latest_revision() {
    gh api "repos/$REPO/commits/$(default_branch)" \
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

determinate_nix_action_major() {
    gh release list \
        --repo DeterminateSystems/determinate-nix-action \
        --exclude-drafts \
        --exclude-pre-releases \
        --jq 'map(select(.isLatest)) | first | .tagName' \
        --json isLatest,tagName
}

main() {
    revision=$(get_latest_revision)
    checkout_tag=$(checkout_tag)

    jq -n '$ARGS.named' \
        --arg upstream_action_revision "$revision" \
        --arg "source_tag" "$MAGIC_NIX_CACHE_TAG" \
        --arg "checkout_action_tag" "$checkout_tag" \
        | cat > tools/state.json
}

main
