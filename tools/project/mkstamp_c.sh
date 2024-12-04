#!/usr/bin/env bash

set -eu

REPO="$(echo "$1" | cut -d/ -f1 | tr 'a-z-' 'A-Z_')"
grep "^STABLE_${REPO}_" bazel-out/stable-status.txt | sed -Ee "s/^STABLE_${REPO}_([^ ]+) (.*)/#define \\1 \"\\2\"/"
