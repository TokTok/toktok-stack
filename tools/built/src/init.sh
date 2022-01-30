#!/usr/bin/dumb-init /bin/sh

set -eux

sudo service ssh start

if grep "BEGIN" ~/key.pem; then
  gpg --import ~/key.pem
fi

# Re-initialise third party and git remotes if this is an external volume
# mounted the first time.
if [ ! -d third_party/android/sdk ]; then
  tools/prepare_third_party.sh
fi

if [ -d ~/.vscode-server ]; then sudo chown -R builder:users ~/.vscode-server; fi
if [ -d /src/workspace/.vscode ]; then sudo chown -R builder:users /src/workspace/.vscode; fi

bazel build --config=remote //...

nc -l 0.0.0.0 2000
