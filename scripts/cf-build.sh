#!/usr/bin/env sh
# Cloudflare Workers Builds entrypoint.
# Ensures Hugo Extended is available, then runs the production build.

set -eu

HUGO_VERSION="${HUGO_VERSION:-0.160.1}"

if ! command -v hugo >/dev/null 2>&1; then
  echo "hugo not on PATH — downloading v${HUGO_VERSION} Extended..."
  mkdir -p ./bin
  curl -fsSL \
    "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" \
    | tar -xz -C ./bin hugo
  chmod +x ./bin/hugo
  export PATH="$PWD/bin:$PATH"
fi

hugo version
hugo --gc --minify
