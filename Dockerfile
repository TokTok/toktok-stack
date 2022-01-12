FROM toxchat/bazel:latest

# First, we copy all the unpacked third_party downloads into the image. These
# are rarely changing, so we won't need to rebuild this part of the image often.
# Dependencies installed with apt above should never change, as we should be
# building most things inside Bazel.
WORKDIR /src/workspace
COPY workspace/tools/prepare_android_sdk.sh workspace/tools/prepare_third_party.sh /tmp/
RUN ["/tmp/prepare_third_party.sh"]

# We set up a builder user with uid/gid 1000. This is what will run on the CI,
# and if our outside user has the same uid, "make run-local" will work well. We
# must run aquery as this user so that the cache is built in the right home
# directory.
RUN groupadd -r -g 1000 builder \
 && useradd -m --no-log-init -r -g builder -u 1000 builder \
 && chown builder:builder /src/workspace
USER builder

# Next, we copy the bare minimum to run a successful aquery. The aquery will
# download GHC and some other large dependencies that rarely change. We copy the
# minimum number of files to avoid rebuilding this when making changes to the
# toktok-stack tools.
COPY workspace/tools/bazelrc.boot /src/workspace/.bazelrc
COPY workspace/BUILD.bazel workspace/WORKSPACE workspace/.bazelignore /src/workspace/
COPY workspace/third_party /src/workspace/third_party
COPY workspace/tools/config /src/workspace/tools/config
COPY workspace/tools/toolchain /src/workspace/tools/toolchain
COPY workspace/tools/workspace /src/workspace/tools/workspace
RUN bazel aquery --config=docker --output=proto --show_timestamps //... > /dev/null

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY --chown=builder:builder workspace /src/workspace/

# Append the Docker image default configs to .bazelrc. This allows child images
# to have their own .bazelrc.local.
RUN echo 'import %workspace%/tools/bazelrc.docker' >> /src/workspace/.bazelrc

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded above.
RUN bazel aquery --output=proto //... > /dev/null
