#! /usr/bin/env bash

set -e
set -ux

seed="$(date)-$RANDOM"

log="${MAGIC_NIX_CACHE_DAEMONDIR}/daemon.log"

flakehub_binary_cache=https://cache.flakehub.com
gha_binary_cache=http://127.0.0.1:37515

is_gh_throttled() {
  grep 'GitHub Actions Cache throttled Magic Nix Cache' "${log}"
}

# Check that the action initialized correctly.
grep 'FlakeHub cache is enabled' "${log}"
grep 'Using cache' "${log}"

if [ "$EXPECT_GITHUB_CACHE" == "true" ]; then
  grep 'GitHub Action cache is enabled' "${log}"
else
  grep 'Native GitHub Action cache is disabled' "${log}"
fi

# Build something.
outpath=$(nix-build .github/workflows/cache-tester.nix --argstr seed "$seed")

# Wait until it has been pushed succesfully.
found=
for ((i = 0; i < 60; i++)); do
    sleep 1
    if grep "✅ $(basename "${outpath}")" "${log}"; then
        found=1
        break
    fi
done
if [[ -z $found ]]; then
    echo "FlakeHub push did not happen." >&2
    exit 1
fi

if [ "$EXPECT_GITHUB_CACHE" == "true" ]; then
  found=
  for ((i = 0; i < 60; i++)); do
      sleep 1
      if grep "Uploaded '${outpath}' to the GitHub Action Cache" "${log}"; then
          found=1
          break
      fi
  done
  if [[ -z $found ]]; then
      echo "GitHub Actions Cache push did not happen." >&2

      if ! is_gh_throttled; then
        exit 1
      fi
  fi
fi



# Check the FlakeHub binary cache to see if the path is really there.
nix path-info --store "${flakehub_binary_cache}" "${outpath}"

if [ "$EXPECT_GITHUB_CACHE" == "true" ] && ! is_gh_throttled; then
  # Check the GitHub binary cache to see if the path is really there.
  nix path-info --store "${gha_binary_cache}" "${outpath}"
fi

rm ./result
nix store delete "${outpath}"
if [ -f "$outpath" ]; then
    echo "$outpath still exists? can't test"
    exit 1
fi

rm -rf ~/.cache/nix

echo "-------"
echo "Trying to substitute the build again..."
echo "if it fails, the cache is broken."

# Check the FlakeHub binary cache to see if the path is really there.
nix path-info --store "${flakehub_binary_cache}" "${outpath}"

if [ "$EXPECT_GITHUB_CACHE" == "true" ] && ! is_gh_throttled; then
  # Check the FlakeHub binary cache to see if the path is really there.
  nix path-info --store "${gha_binary_cache}" "${outpath}"
fi

nix-store --realize -vvvvvvvv "$outpath"
