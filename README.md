# TokTok stack

## Downloading

To download the TokTok stack, use `git`:

```sh
git clone --recursive https://github.com/TokTok/toktok-stack
```

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

#### Maven

If you want to build Java binaries, you need to install Maven:

```sh
sudo apt install maven
```

On OSX:

```sh
brew install maven
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

#### Qt5

To build Qt-based binaries such as `qtox`, you need an installation of Qt
development headers and libraries and tools.

```sh
sudo apt install qttools5-dev libqt5svg5-dev
```

The build expects symlinks to the development files in `third_party/qt`:

```sh
ln -s /usr/lib/x86_64-linux-gnu/qt5/bin third_party/qt/bin
ln -s /usr/include/x86_64-linux-gnu/qt5 third_party/qt/include
ln -s /usr/lib/x86_64-linux-gnu third_party/qt/lib
```

On OSX:

```sh
brew install qt
ln -s /usr/local/Cellar/qt/5.14.1/bin third_party/qt/bin
ln -s /usr/local/Cellar/qt/5.14.1/include third_party/qt/include
ln -s /usr/local/Cellar/qt/5.14.1/lib third_party/qt/lib
```

You may need slightly different paths depending on where your Qt installation
lives.

#### Python

To build `py-toxcore-c` and other programs using Python FFI, you need Python
development headers. `py-toxcore-c` and `toxic` both need Python 3. Any of
3.5, 3.6, or 3.7 works.

```sh
sudo apt install python3.5-dev
```

#### Make

For `//js-toxcore-c`, you will need a `make` program in your `$PATH`:

```sh
sudo apt install make
```

#### Native javacpp libraries

Streambot needs native libraries that need to be downloaded from Maven.

```sh
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/3.4.1-1.4/ffmpeg-3.4.1-1.4-linux-x86_64.jar -O third_party/javacpp/ffmpeg/jar/ffmpeg-3.4.1-1.4-linux-x86_64.jar
wget https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/3.4.0-1.4/opencv-3.4.0-1.4-linux-x86_64.jar -O third_party/javacpp/opencv/jar/opencv-3.4.0-1.4-linux-x86_64.jar
```

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

Note that toxic also needs Python 3. See the section on Python for how to
install its development files.

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

Note that the version of clang coming with android-ndk-r16b needs
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
