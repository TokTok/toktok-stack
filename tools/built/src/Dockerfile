FROM toxchat/toktok-stack:latest-third_party

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY --chown=builder:users . /src/workspace/

RUN echo 'build --config=ci --config=nix' >/src/workspace/.local.bazelrc; \
 if curl -s -m1 http://code.tox.chat/bazel/ \
   | grep "resource name must be a SHA256 hash"; then \
   echo 'build --config=remote-grpc' | tee -a .local.bazelrc; \
 fi

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded in the third_party
# image we built before this one.
RUN sudo nix-daemon --daemon & bazel aquery --output=proto //... >/dev/null
