#!/usr/bin/env bash

set -eu

# Usage: mkstamp_c.sh <repo> version.cpp.in > version.cpp
#
# For each of the STABLE_{REPO}_* variables, do a search/replace in the input
# file, replacing the variable name with the value. Variable names in the input
# are e.g. @GIT_VERSION@.

REPO="$(echo "$1" | cut -d/ -f1 | tr 'a-z-' 'A-Z_')"
INPUT="$2"

# First make a map of all the variables and their values.
declare -A STABLE

while read -r line; do
  if [[ "$line" =~ ^STABLE_${REPO}_([A-Z_]+)\ (.*) ]]; then
    STABLE["${BASH_REMATCH[1]}"]="${BASH_REMATCH[2]}"
  fi
done <bazel-out/stable-status.txt

# Then do the search/replace.
while IFS= read -r line; do
  for key in "${!STABLE[@]}"; do
    line="${line//@${key}@/${STABLE[$key]}}"
  done
  echo "$line"
done <"$INPUT"
