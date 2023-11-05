#!/bin/sh

set -eux

sudo nix-daemon --daemon &
sleep 1 # wait for daemon to arrive (race, but *shrug*)

if grep "BEGIN" ~/key.pem; then
  nix-shell -p gnupg --run "gpg --import ~/key.pem"
fi
