#!/usr/bin/dumb-init /bin/sh

set -eux

sudo openrc
sudo touch /run/openrc/softlevel
sudo openrc -s sshd start

echo hi

# Start Tor node for any local testing.
#sudo service tor start

# Install a default .bazelrc.local that works with the dev container.
if [ ! -f .bazelrc.local ]; then ln -s .bazelrc.local.example .bazelrc.local; fi

if [ -d ~/.vscode-server ]; then sudo chown -R builder:users ~/.vscode-server; fi
if [ -d /src/workspace/.vscode ]; then sudo chown -R builder:users /src/workspace/.vscode; fi

bazel-compdb
bazel build --config=remote //...

exec nix-shell -p netcat --run "nc -l 0.0.0.0 2000"
