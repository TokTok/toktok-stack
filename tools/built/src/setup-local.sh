#!/bin/sh

set -eux

if grep "BEGIN" ~/key.pem; then
  nix-shell -p gnupg --run "gpg --import ~/key.pem"
fi
