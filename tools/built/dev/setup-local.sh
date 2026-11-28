#!/bin/bash

set -eux

sudo rm -f /nix/var/nix/daemon-socket/socket
sudo nix-daemon --daemon >/dev/null 2>&1 &
trap 'sudo pkill -x nix-daemon 2>/dev/null || true; sudo rm -f /nix/var/nix/daemon-socket/socket' EXIT
for _ in {1..50}; do
  [ -S /nix/var/nix/daemon-socket/socket ] && break
  sleep 0.2
done
export NIX_REMOTE=daemon

if grep "BEGIN" ~/key.pem; then
  nix-shell -p gnupg --run "gpg --import ~/key.pem"
fi

# Clean up old sockets and lock files that might be left over from a previous
# run, as well as from the above import.
#
# If we don't do this, gpg will hang trying to connect to the keybox socket.
rm -f ~/.gnupg/S.*
rm -f ~/.gnupg/public-keys.d/pubring.db.lock

# Apply the user's home.nix overlay using the pinned home-manager already
# installed in ~/.nix-profile rather than nix-shell -p home-manager (which
# pulls nixpkgs's older version).
"$HOME/.nix-profile/bin/home-manager" switch
