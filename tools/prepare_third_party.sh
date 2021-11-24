#!/bin/sh

set -eux

if [ ! -d third_party/android/android-ndk-r21d ]; then
  wget https://dl.google.com/android/repository/android-ndk-r21d-linux-x86_64.zip
  mkdir -p third_party/android/
  unzip -d third_party/android/ android-ndk-r21d-linux-x86_64.zip
  rm android-ndk-r21d-linux-x86_64.zip
fi

if ! which javac; then
  if which apk; then
    apk --no-cache add openjdk8
  elif which apt-get; then
    apt-get install default-jdk
  else
    echo "No javac and no known package manager to install it with"
    exit 1
  fi
fi

if [ ! -d third_party/android/sdk/tools ]; then
  wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
  mkdir -p third_party/android/sdk/
  unzip -d third_party/android/sdk/ commandlinetools-linux-7583922_latest.zip
  rm commandlinetools-linux-7583922_latest.zip
  yes | third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk --licenses
  touch "$HOME/.android/repositories.cfg"
  third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk "tools"
  third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk "build-tools;30.0.0"
  third_party/android/sdk/cmdline-tools/bin/sdkmanager --sdk_root=third_party/android/sdk "platforms;android-28"
fi

mkdir -p third_party/javacpp/ffmpeg/jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/3.4.1-1.4/ffmpeg-3.4.1-1.4-linux-x86_64.jar -O third_party/javacpp/ffmpeg/jar/ffmpeg-3.4.1-1.4-linux-x86_64.jar
mkdir -p third_party/javacpp/opencv/jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/3.4.0-1.4/opencv-3.4.0-1.4-linux-x86_64.jar -O third_party/javacpp/opencv/jar/opencv-3.4.0-1.4-linux-x86_64.jar
