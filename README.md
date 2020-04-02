# TokTok stack

## Downloading

To download the TokTok stack, use `git`:

```sh
git clone --recursive https://github.com/TokTok/toktok-stack
```

## Configuring

You'll need to pass `--config` flags to make bazel select the correct compiler
flags. If you're on Linux, pass `--config=linux`, on OSX, pass `--config=osx`,
and on Windows, pass `--config=windows`.

You must also pass the correct compiler config. If you use Clang (default on
OSX), pass `--config=clang`. If you use GCC, pass `--config=gcc`. On Windows,
you don't need any compiler flag because we assume it's MSVC.

There are also `--config=release` and `--config=debug`, as well as
`--config=asan` flags, and more. See `.bazelrc` in this repository for more
config flags you can pass.

We recommend creating a `$HOME/.bazelrc` roughly like this:

```sh
build --jobs=12

build --config=linux
build --config=clang
#build --config=gcc
build --config=release
#build --config=ubsan
```

The shell script at `tools/setup-ci` does this for you on Linux/Clang, but
also sets up remote caching, which you may not want if you don't have a very
fast internet connection.

## Building

After installing prerequisites (instructions below), run the following command
in the `toktok-stack` directory:

```sh
bazel build //...
```

### Installing prerequisites

To build the stack, first you need to install some software. This guide
assumes an installation of Debian GNU/Linux version 9 and that you are in the
`toktok-stack` directory. There is partial support for Mac OS X and FreeBSD,
but not all targets can be built on those systems.

#### Bazel

Install the latest version of
[Bazel](https://github.com/bazelbuild/bazel/releases), e.g.:

```sh
wget https://github.com/bazelbuild/bazel/releases/download/2.2.0/bazel_2.2.0-linux-x86_64.deb
sudo dpkg -i bazel_2.2.0-linux-x86_64.deb
```

On OSX:

```sh
brew install bazel
```

On FreeBSD:

```sh
sudo pkg install bazel
```

On Windows:

```sh
choco install bazel
```

#### Qt5

To build Qt-based binaries such as `qtox`, you need an installation of Qt
development headers and libraries and tools.

```sh
sudo apt install qttools5-dev qttools5-dev-tools libqt5svg5-dev
```

On OSX:

```sh
brew install qt
```

On FreeBSD:

```sh
sudo pkg install qt5
```

On Windows:

```sh
choco install qt
```

If your Qt installation doesn't live in a standard location, make changes to
the detector script in `tools/workspace/qt.bzl` and consider sending us a pull
request. If your version of Qt is different, edit `WORKSPACE` and adjust it in
the `qt_repository` declaration.

#### Extra development packages

Some libraries have not yet been imported into `third_party`, so must be
installed on the system.

For `//qtox`:

```sh
sudo apt install libopenal-dev libasound2-dev libxss-dev
```

For `//toxic`:

```sh
sudo apt install libopenal-dev libxss-dev
```

On OSX (for both `qtox` and `toxic`):

```sh
brew install ncurses openal-soft
```

On FreeBSD:

```sh
sudo pkg install ncurses openal-soft
```

Note that toxic also needs Python 3. See the section on Python for how to
install its development files.

#### Python

To build `py-toxcore-c` and other programs using Python FFI, you need Python
development headers. `py-toxcore-c` and `toxic` both need Python 3. Any of
3.5, 3.6, or 3.7 works.

```sh
sudo apt install python3.5-dev
```

On FreeBSD:

```sh
sudo pkg install python3
```

#### Native javacpp libraries

Streambot needs native libraries that need to be downloaded from Maven.

```sh
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/3.4.1-1.4/ffmpeg-3.4.1-1.4-linux-x86_64.jar -O third_party/javacpp/ffmpeg/jar/ffmpeg-3.4.1-1.4-linux-x86_64.jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/3.4.0-1.4/opencv-3.4.0-1.4-linux-x86_64.jar -O third_party/javacpp/opencv/jar/opencv-3.4.0-1.4-linux-x86_64.jar
```

#### Android SDK

If you want to build Android apps such as `toktok-android`, you need the
[Android SDK](https://developer.android.com/studio/index.html). E.g.:

```sh
wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
unzip -d third_party/android/sdk/ commandlinetools-linux-6200805_latest.zip
rm commandlinetools-linux-6200805_latest.zip
```

On OSX, replace `linux` with `mac` in the above instructions.

You will need to install the latest build tools (`aapt` and friends) and
platform 28 (targeted by our Android apps) using the SDK manager. Press "y"
to accept all the licenses as you are asked. Use `sdkmanager --list` to see
the latest versions of each package after updating.

```sh
third_party/android/sdk/tools/bin/sdkmanager --update
third_party/android/sdk/tools/bin/sdkmanager 'build-tools;29.0.2'
third_party/android/sdk/tools/bin/sdkmanager 'platforms;android-28'
```

If you want to run instrumentation tests, also install an emulator image:

```sh
third_party/android/sdk/tools/bin/sdkmanager 'system-images;android-28;default;x86'
```

If you get `Warning: Could not create settings` and an exception, run the
following steps instead of the `--update` step:

```sh
third_party/android/sdk/tools/bin/sdkmanager --sdk_root=third_party/android/sdk --update
third_party/android/sdk/tools/bin/sdkmanager --sdk_root=third_party/android/sdk 'tools'
```

From then on, you won't need the `--sdk_root` flag anymore. See
[this](https://stackoverflow.com/a/60454207) stackoverflow for more details.

If you're using Java 11, see [this](https://stackoverflow.com/a/55982976)
stackoverflow answer if you're getting exceptions or other errors when running
sdkmanager.

## Building native code for Android

After installing prerequisites (instructions below), run:

```sh
bazel build --config=android //c-toxcore/auto_tests/...
```

WARNING: This build mode does not work at all, yet. Patches welcome!

### Installing Android prerequisites

#### NDK

```sh
wget https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip
unzip -d third_party/android/ android-ndk-r16b-linux-x86_64.zip
```

Note that the version of Clang coming with android-ndk-r16b needs
libncurses.so.5, which on Debian is in the libncurses5 package.

On OSX, replace `linux` with `darwin`.

## Troubleshooting

### Xcode version must be specified to use an Apple CROSSTOOL

Try running the following:

```sh
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license
bazel clean --expunge
```

See
[this](https://github.com/bazelbuild/bazel/issues/4314#issuecomment-370172472)
GitHub comment or [this](https://stackoverflow.com/a/46460129) stackoverflow
answer for more details.
