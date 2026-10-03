#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAMS="$(dirname "$ROOT")/_upstreams"
mkdir -p "$UPSTREAMS"

if [ ! -d "$UPSTREAMS/woonext/.git" ]; then
  git clone https://github.com/Invizo/woonext.git "$UPSTREAMS/woonext"
else
  echo "WooNext already exists: $UPSTREAMS/woonext"
fi

if [ ! -d "$UPSTREAMS/next-woo/.git" ]; then
  git clone https://github.com/9d8dev/next-woo.git "$UPSTREAMS/next-woo"
else
  echo "Next Woo already exists: $UPSTREAMS/next-woo"
fi

echo
echo "Upstreams ready in $UPSTREAMS"
echo "Primary audit target: $UPSTREAMS/woonext"
echo "Read CLAUDE.md and docs/IMPLEMENTATION_PLAN.md before merging/copying anything."
