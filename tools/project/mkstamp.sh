#!/usr/bin/env bash

set -eu

REPOS=(c-toxcore qtox)

for repo in "${REPOS[@]}"; do
  cd "$repo"
  REPO="$(echo "$repo" | tr 'a-z-' 'A-Z_')"
  echo "STABLE_${REPO}_GIT_DESCRIBE_EXACT" "$(git describe --exact-match --tags HEAD 2>/dev/null || echo 'Nightly')"
  echo "STABLE_${REPO}_GIT_DESCRIBE" "$(git describe --tags 2>/dev/null || echo 'Nightly')"
  echo "STABLE_${REPO}_GIT_VERSION" "$(git rev-parse HEAD 2>/dev/null || echo 'build without git')"
  cd -
done
