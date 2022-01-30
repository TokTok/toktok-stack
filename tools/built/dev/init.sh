#!/usr/bin/dumb-init /bin/sh

set -eux

sudo service ssh start

if grep "BEGIN" ~builder/key.pem; then
  sudo -i -u builder gpg --import ~builder/key.pem
fi

# Re-initialise third party and git remotes if this is an external volume
# mounted the first time.
if [ ! -d third_party/android/sdk ]; then
  tools/prepare_third_party.sh
  tools/git-remotes "$GITHUB_USER"
fi

sudo chown -R builder:users /home/builder/.vscode-server /src/workspace/.vscode
sudo -i -u builder bazel build //...

nc -l 0.0.0.0 2000
