#!/bin/bash

export THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -eux

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

FFMPEG_VERSION=3.4.1-1.4
OPENCV_VERSION=3.4.0-1.4

FFMPEG_JAR=ffmpeg-$FFMPEG_VERSION-linux-x86_64.jar
OPENCV_JAR=opencv-$OPENCV_VERSION-linux-x86_64.jar

if [ ! -f "third_party/javacpp/ffmpeg/jar/$FFMPEG_JAR" ]; then
  mkdir -p third_party/javacpp/ffmpeg/jar
  wget -q "https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/$FFMPEG_VERSION/$FFMPEG_JAR" -O "third_party/javacpp/ffmpeg/jar/$FFMPEG_JAR"
fi
if [ ! -f "third_party/javacpp/opencv/jar/$OPENCV_JAR" ]; then
  mkdir -p third_party/javacpp/opencv/jar
  wget -q "https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/$OPENCV_VERSION/$OPENCV_JAR" -O "third_party/javacpp/opencv/jar/$OPENCV_JAR"
fi
