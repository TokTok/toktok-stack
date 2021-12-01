#!/bin/bash

export THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -eux

"$THIS_DIR/prepare_android_sdk.sh"

if [ ! -d third_party/android/android-ndk-r21d ]; then
  wget -q https://dl.google.com/android/repository/android-ndk-r21d-linux-x86_64.zip
  mkdir -p third_party/android/
  unzip -q -d third_party/android/ android-ndk-r21d-linux-x86_64.zip
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

mkdir -p third_party/javacpp/ffmpeg/jar
wget -q https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/3.4.1-1.4/ffmpeg-3.4.1-1.4-linux-x86_64.jar -O third_party/javacpp/ffmpeg/jar/ffmpeg-3.4.1-1.4-linux-x86_64.jar
mkdir -p third_party/javacpp/opencv/jar
wget -q https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/3.4.0-1.4/opencv-3.4.0-1.4-linux-x86_64.jar -O third_party/javacpp/opencv/jar/opencv-3.4.0-1.4-linux-x86_64.jar
