# TokTok stack

## Building

### Installing prerequisites

To build the stack, first you need to install some software. This guide
assumes an installation of Debian GNU/Linux and that you are in the
`toktok-stack` directory.

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

#### Qt5

To build Qt-based binaries such as `qtox`, you need an installation of Qt
development headers and libraries and tools.

```sh
$ sudo apt install qttools5-dev
```

The build expects symlinks to the development files in `third_party/qt`:

```sh
$ ln -s /usr/lib/x86_64-linux-gnu/qt5/bin third_party/qt/bin
$ ln -s /usr/include/x86_64-linux-gnu/qt5 third_party/qt/include
# ln -s /usr/lib/x86_64-linux-gnu third_party/qt/lib
```

#### Python

To build `py-toxcore-c` and other programs using Python FFI, you need Python
development headers. `py-toxcore-c` currently uses Python 2.7.

```sh
$ sudo apt install python2.7-dev
```
