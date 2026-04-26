#!/usr/bin/env sh
# Cloudflare Workers Builds entrypoint.
#
# Always installs a pinned Hugo Extended release into ./bin and uses it,
# regardless of any pre-installed `hugo` on PATH. The Cloudflare Workers
# build environment ships an older Hugo (v0.147.x) that is incompatible
# with current Blowfish (which uses .Site.Language.Locale, introduced in
# Hugo v0.158.0).

set -eu

HUGO_VERSION="${HUGO_VERSION:-0.160.1}"
HUGO_BIN="./bin/hugo"

mkdir -p ./bin

if [ ! -x "$HUGO_BIN" ] || ! "$HUGO_BIN" version 2>/dev/null | grep -q "v${HUGO_VERSION}"; then
  echo "Installing Hugo Extended v${HUGO_VERSION}..."
  curl -fsSL \
    "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" \
    | tar -xz -C ./bin hugo
  chmod +x "$HUGO_BIN"
fi

"$HUGO_BIN" version
"$HUGO_BIN" --gc --minify
