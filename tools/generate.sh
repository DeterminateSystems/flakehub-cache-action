#!/bin/sh

# Allow "useless" cat
# shellcheck disable=SC2002

set -eux

REPO="DeterminateSystems/magic-nix-cache-action"
FILEPATH="action.yml"

get_action_as_json() (
    rev=$1

    curl -s -L "https://raw.githubusercontent.com/$REPO/$rev/$FILEPATH" \
        | yq
)

main() {

    echo "::group::{./tools/state.json}"
    cat ./tools/state.json
    echo "::endgroup::"


    upstream_action_revision=$(cat ./tools/state.json | jq -r .upstream_action_revision)

    get_action_as_json "$upstream_action_revision" > upstream.json

    echo "::group::{./upstream.json}"
    cat ./upstream.json
    echo "::endgroup::"

    python3 -- ./tools/generate.py \
        ./tools/state.json \
        ./upstream.json \
        ./action.yml \
        ./tools/README.template.md \
        ./README.md

    rm ./upstream.json
}

main
