FROM toxchat/toktok-stack:latest-third_party

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY --chown=builder:users . /src/workspace/

RUN echo 'build --config=ci --config=nix' >/src/workspace/.bazelrc.local

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded in the third_party
# image we built before this one.
RUN sudo nix-daemon --daemon & bazel aquery --output=proto //... >/dev/null
