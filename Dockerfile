FROM alpine:3.11.5 AS downloads

WORKDIR /src/toktok-stack

RUN ["wget", "https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip"]
RUN ["mkdir", "-p", "third_party/android/"]
RUN ["unzip", "-d", "third_party/android/", "android-ndk-r16b-linux-x86_64.zip"]
RUN ["rm", "android-ndk-r16b-linux-x86_64.zip"]

RUN ["wget", "https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip"]
RUN ["apk", "--no-cache", "add", "openjdk8"]
RUN ["mkdir", "-p", "third_party/android/sdk/"]
RUN ["unzip", "-d", "third_party/android/sdk/", "commandlinetools-linux-6200805_latest.zip"]
RUN ["rm", "commandlinetools-linux-6200805_latest.zip"]
RUN yes | third_party/android/sdk/tools/bin/sdkmanager --sdk_root=third_party/android/sdk --licenses
RUN ["touch", "/root/.android/repositories.cfg"]
RUN ["third_party/android/sdk/tools/bin/sdkmanager", "--sdk_root=third_party/android/sdk", "tools"]
RUN ["third_party/android/sdk/tools/bin/sdkmanager", "build-tools;29.0.2"]
RUN ["third_party/android/sdk/tools/bin/sdkmanager", "platforms;android-28"]

RUN ["mkdir", "-p", "third_party/javacpp/ffmpeg/jar"]
RUN ["wget", "https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/ffmpeg/3.4.1-1.4/ffmpeg-3.4.1-1.4-linux-x86_64.jar", "-O", "third_party/javacpp/ffmpeg/jar/ffmpeg-3.4.1-1.4-linux-x86_64.jar"]
RUN ["mkdir", "-p", "third_party/javacpp/opencv/jar"]
RUN ["wget", "https://repo1.maven.org/maven2/org/bytedeco/javacpp-presets/opencv/3.4.0-1.4/opencv-3.4.0-1.4-linux-x86_64.jar", "-O", "third_party/javacpp/opencv/jar/opencv-3.4.0-1.4-linux-x86_64.jar"]

FROM l.gcr.io/google/bazel:3.0.0
RUN apt-get update && apt-get install -y --no-install-recommends \
 libasound2-dev=1.1.0-0ubuntu1 \
 libgmp-dev=2:6.1.0+dfsg-2 \
 libncurses5-dev=6.0+20160213-1ubuntu1 \
 libncursesw5-dev=6.0+20160213-1ubuntu1 \
 libqt5opengl5-dev=5.5.1+dfsg-16ubuntu7.7 \
 libqt5svg5-dev=5.5.1-2build1 \
 libssl-dev=1.0.2g-1ubuntu4.15 \
 libx264-dev=2:0.148.2643+git5c65704-1 \
 make=4.1-6 \
 maven=3.3.9-3 \
 qtmultimedia5-dev=5.5.1-4ubuntu2 \
 qttools5-dev=5.5.1-3ubuntu0.1 \
 qttools5-dev-tools=5.5.1-3ubuntu0.1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# First, we copy all the unpacked third_party downloads into the image. These
# are rarely changing, so we won't need to rebuild this part of the image often.
# Dependencies installed with apt above should never change, as we should be
# building most things inside Bazel.
WORKDIR /src/workspace
COPY --from=downloads /src/toktok-stack /src/workspace

# We set up a builder user with uid/gid 1000. This is what will run on the CI,
# and if our outside user has the same uid, "make run-local" will work well. We
# must run aquery as this user so that the cache is built in the right home
# directory.
RUN groupadd -r -g 1000 builder \
 && useradd --no-log-init -r -g builder -u 1000 builder \
 && mkdir -p /src/workspace /home/builder \
 && chown builder:builder /home/builder
USER builder

# Next, we copy the bare minimum to run a successful aquery. The aquery will
# download GHC and some other large dependencies that rarely change. We copy the
# minimum number of files to avoid rebuilding this when making changes to the
# toktok-stack tools.
COPY workspace/WORKSPACE workspace/.bazelrc /src/workspace/
COPY workspace/third_party /src/workspace/third_party
COPY workspace/tools/config /src/workspace/tools/config
COPY workspace/tools/workspace /src/workspace/tools/workspace
RUN bazel aquery --output=proto --show_timestamps //... > /dev/null

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY workspace /src/workspace/

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded above.
RUN bazel aquery --output=proto --show_timestamps //... > /dev/null

ENTRYPOINT ["/bin/bash"]
