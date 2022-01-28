#!/bin/sh

set -eux

service ssh start

if grep "BEGIN" ~builder/key.pem; then
  sudo -i -u builder gpg --import ~builder/key.pem
fi

# Re-initialise third party and git remotes if this is an external volume
# mounted the first time.
if [ ! -d third_party/android/sdk ]; then
  tools/prepare_third_party.sh
  tools/git-remotes "$GITHUB_USER"
fi

sudo -i -u builder bazel build //...

exec netcat -l 0.0.0.0 2000
