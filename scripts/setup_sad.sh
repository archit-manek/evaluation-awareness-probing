#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$repo_root/notebooks/sad"
url="https://github.com/LRudL/sad.git"

if [ -d "$target/.git" ]; then
  echo "SAD already exists at $target"
  exit 0
fi

if [ -e "$target" ]; then
  echo "Error: $target exists but is not a Git checkout." >&2
  echo "Move or remove it before rerunning this setup script." >&2
  exit 1
fi

git clone --depth 1 "$url" "$target"
echo "SAD cloned to $target"
