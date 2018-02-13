# TokTok stack

## Building

### Installing prerequisites

To build the stack, first you need to install some software. This guide
assumes an installation of Debian GNU/Linux version 9 and that you are in the
`toktok-stack` directory. There is partial support for Mac OS X and FreeBSD,
but not all targets can be built on those systems.

#### Bazel

Install the latest version of
[Bazel](https://github.com/bazelbuild/bazel/releases), e.g.:

```sh
$ wget https://github.com/bazelbuild/bazel/releases/download/0.10.0/bazel_0.10.0-linux-x86_64.deb
$ sudo dpkg -i bazel_0.10.0-linux-x86_64.deb
```

#### Maven

If you want to build Java binaries, you need to install Maven:

```sh
$ sudo apt install maven
```

#### Android SDK

If you want to build Android apps such as `toktok-android`, you need the
[Android SDK](https://developer.android.com/studio/index.html). E.g.:

```sh
$ wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
$ unzip -d third_party/android/sdk/ sdk-tools-linux-3859397.zip
$ rm sdk-tools-linux-3859397.zip
```

You will need to install the latest build tools (`aapt` and friends) and
platform 27 (targetted by our Android apps) using the SDK manager. Press "y"
to accept all the licenses as you are asked. Use `sdkmanager --list` to see
the latest versions of each package after updating.

```sh
$ third_party/android/sdk/tools/bin/sdkmanager --update
$ third_party/android/sdk/tools/bin/sdkmanager 'build-tools;27.0.3'
$ third_party/android/sdk/tools/bin/sdkmanager 'platforms;android-27'
```

#### Qt5

To build Qt-based binaries such as `qtox`, you need an installation of Qt
development headers and libraries and tools.

```sh
$ sudo apt install qttools5-dev libqt5svg5-dev
```

The build expects symlinks to the development files in `third_party/qt`:

```sh
$ ln -s /usr/lib/x86_64-linux-gnu/qt5/bin third_party/qt/bin
$ ln -s /usr/include/x86_64-linux-gnu/qt5 third_party/qt/include
# ln -s /usr/lib/x86_64-linux-gnu third_party/qt/lib
```

#### Python

To build `py-toxcore-c` and other programs using Python FFI, you need Python
development headers. `py-toxcore-c` currently builds for Python 2 in the Bazel
build.

```sh
$ sudo apt install python2.7-dev
```

#### Haskell

To build our Haskell software, you need to install GHC:

```sh
$ sudo apt install ghc
```

The build assumes version 8.0.1. No other packages need to be installed, as
all cabal packages will be built by Bazel.

#### Make

For `//js-toxcore-c`, you will need a `make` program in your `$PATH`:

```sh
$ sudo apt install make
```

#### Mercurial

For `//qtox/osx/updater`, you will need the `hg` program in your `$PATH`,
because it contains a Go program that points at a Bitbucket Mercurial
repository:

```sh
$ sudo apt install mercurial
```

#### Native javacpp libraries

Streambot needs native libraries that need to be downloaded from Maven.

```sh
$ wget http://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/3.4.1-1.4/ffmpeg-3.4.1-1.4-linux-x86_64.jar -O third_party/javacpp/ffmpeg/jar/ffmpeg-3.4.1-1.4-linux-x86_64.jar
$ wget http://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/3.4.0-1.4/opencv-3.4.0-1.4-linux-x86_64.jar -O third_party/javacpp/opencv/jar/opencv-3.4.0-1.4-linux-x86_64.jar
```

#### Extra development packages

Some libraries have not yet been imported into `third_party`, so must be
installed on the system.

For `//qtox`:
```sh
$ sudo apt install libopenal-dev libsqlite3-dev libasound2-dev libxss-dev
```

For `//c-toxcore/testing:av_test`:
```sh
$ sudo apt install libcv-dev libhighgui-dev
```
