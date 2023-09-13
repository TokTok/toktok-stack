FROM toxchat/toktok-stack:latest-third_party

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY --chown=builder:users . /src/workspace/

# Append the Docker image default configs to .bazelrc. This allows child images
# to have their own .bazelrc.local.
RUN echo "import %workspace%/tools/bazelrc.docker" >> /src/workspace/.bazelrc

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded above.
RUN du -sh $HOME/.cache/bazel/_bazel_builder \
 && bazel aquery --output=proto //... > /dev/null \
 && du -sh $HOME/.cache/bazel/_bazel_builder
