#!/bin/sh

set -eu

SETTINGS="$1"
PACKAGE="$2"

NAME=$(grep '^  name:' "$SETTINGS" | awk '{print $2}')
REPO=$(echo "$PACKAGE" | grep -o '[^/]*$')

if [ "$NAME" != "$REPO" ]; then
  echo "repository.name '$NAME' in $SETTINGS does not match the expected repo name '$REPO'"
  exit 1
fi
