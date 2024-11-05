#!/bin/sh

set -eux

sudo nix-daemon --daemon &
sleep 1 # wait for daemon to arrive (race, but *shrug*)

if grep "BEGIN" ~/key.pem; then
  nix-shell -p gnupg --run "gpg --import ~/key.pem"
fi

# Clean up old sockets and lock files that might be left over from a previous
# run, as well as from the above import.
#
# If we don't do this, gpg will hang trying to connect to the keybox socket.
rm -f ~/.gnupg/S.*
rm -f ~/.gnupg/public-keys.d/pubring.db.lock

# Install all the packages from home.nix now that (hopefully) we have a github
# token.
nix-shell -p home-manager --run "home-manager switch"
