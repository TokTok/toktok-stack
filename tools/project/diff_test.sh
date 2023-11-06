#!/usr/bin/env bash

set -eu
DIFF=$1
shift

exec "$DIFF" -u <(sed -e 's/secure: "[^"]*"/secure: "SECURE"/g' "$1") "$2"
