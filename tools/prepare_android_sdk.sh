#!/bin/sh

set -eux

if [ ! -d third_party/android/sdk/cmdline-tools ]; then
  wget -q https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
  mkdir -p third_party/android/sdk/
  unzip -q -d third_party/android/sdk/ commandlinetools-linux-7583922_latest.zip
  rm commandlinetools-linux-7583922_latest.zip
  yes | third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk --licenses
  touch "$HOME/.android/repositories.cfg"
  third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk "tools"
  third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk "build-tools;30.0.0"
  third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk "platforms;android-28"
fi
