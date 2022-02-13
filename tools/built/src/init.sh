#!/usr/bin/dumb-init /bin/sh

set -eux

sudo service ssh start

# Re-initialise third party and git remotes if this is an external volume
# mounted the first time.
tools/prepare_third_party.sh

# Install a default .bazelrc.local that works with the dev container.
if [ ! -f .bazelrc.local ]; then ln -s .bazelrc.local.example .bazelrc.local; fi

if [ -d ~/.vscode-server ]; then sudo chown -R builder:users ~/.vscode-server; fi
if [ -d /src/workspace/.vscode ]; then sudo chown -R builder:users /src/workspace/.vscode; fi

bazel-compdb
bazel build --config=remote //...

nc -l 0.0.0.0 2000
