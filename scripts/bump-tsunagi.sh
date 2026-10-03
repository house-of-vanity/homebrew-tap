#!/usr/bin/env bash
# Point the tsunagi formula and cask at a release.
#
# Usage: scripts/bump-tsunagi.sh <version>     e.g. 0.1.0-rc.22 (no leading v)
#
# Downloads the release's macOS archive once, takes its sha256, and rewrites the
# version and checksum in Formula/tsunagi.rb and Casks/tsunagi-gui.rb. They share
# one archive, so they move together.
set -euo pipefail

version="${1:?usage: bump-tsunagi.sh <version>}"
version="${version#v}"
here="$(cd "$(dirname "$0")/.." && pwd)"
asset="tsunagi-macos-aarch64-${version}.tar.gz"
url="https://github.com/house-of-vanity/tsunagi/releases/download/v${version}/${asset}"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/$asset" "$url"
if command -v sha256sum >/dev/null 2>&1; then
    sha="$(sha256sum "$tmp/$asset" | cut -d' ' -f1)"
else
    sha="$(shasum -a 256 "$tmp/$asset" | cut -d' ' -f1)"
fi

# The cask installs the app bundle, which older releases do not have.
# Read the listing whole: `grep -q` quits at the first match, and `tar` dying of
# the closed pipe would fail this check under pipefail.
listing="$(tar tzf "$tmp/$asset")"
if ! grep -q 'Tsunagi.app/' <<<"$listing"; then
    echo "note: $asset has no Tsunagi.app; the cask will not install from it" >&2
fi

sed -i.bak -E \
    -e "s/^(  VERSION = \")[^\"]*(\")/\1${version}\2/" \
    -e "s/^(  SHA256 = \")[^\"]*(\")/\1${sha}\2/" \
    "$here/Formula/tsunagi.rb"
sed -i.bak -E \
    -e "s/^(  version \")[^\"]*(\")/\1${version}\2/" \
    -e "s/^(  sha256 \")[^\"]*(\")/\1${sha}\2/" \
    "$here/Casks/tsunagi-gui.rb"
rm -f "$here/Formula/tsunagi.rb.bak" "$here/Casks/tsunagi-gui.rb.bak"

echo "tsunagi ${version}  sha256 ${sha}"
