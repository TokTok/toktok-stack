FROM alpine:3.11.5 AS downloads

WORKDIR /src/toktok-stack

COPY workspace/tools/prepare_third_party.sh /tmp/
RUN ["/tmp/prepare_third_party.sh"]

FROM l.gcr.io/google/bazel:3.1.0
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
 libasound2-dev \
 libgmp-dev \
 libncurses5-dev \
 libncursesw5-dev \
 libqt5opengl5-dev \
 libqt5svg5-dev \
 libssl-dev \
 libx264-dev \
 libxss-dev \
 make \
 maven \
 qtmultimedia5-dev \
 qttools5-dev \
 qttools5-dev-tools \
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
COPY workspace/tools/bazelrc.boot /src/workspace/.bazelrc
COPY workspace/BUILD.bazel workspace/WORKSPACE /src/workspace/
COPY workspace/third_party /src/workspace/third_party
COPY workspace/tools/config /src/workspace/tools/config
COPY workspace/tools/workspace /src/workspace/tools/workspace
RUN bazel aquery --output=proto --show_timestamps //... > /dev/null

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY workspace /src/workspace/

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded above.
RUN bazel aquery --output=proto --config=ci //... > /dev/null

ENTRYPOINT ["/bin/bash"]
