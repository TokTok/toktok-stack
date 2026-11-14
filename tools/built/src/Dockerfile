FROM toxchat/toktok-stack:latest-third_party

# Now we can copy the entire tree. This is expected to change very often, as it
# includes all of the sources of all projects.
COPY --chown=builder:users . /src/workspace/

RUN echo 'build --config=ci --config=nix' >/src/workspace/.local.bazelrc

# Finally, we run another aquery. This will download some more dependencies, but
# the most expensive ones should already have been downloaded in the third_party
# image we built before this one.
RUN sudo rm -f /nix/var/nix/daemon-socket/socket \
 && (sudo nix-daemon --daemon >/dev/null 2>&1 &) \
 && for _ in $(seq 1 50); do [ -S /nix/var/nix/daemon-socket/socket ] && break; sleep 0.2; done \
 && export NIX_REMOTE=daemon \
 && bazel aquery --output=proto //... >/dev/null \
 && nix-collect-garbage -d \
 && rm -rf /home/builder/.cache/bazel/_bazel_builder/cache/repos/v1/content_addressable \
 && (sudo pkill -x nix-daemon || true) \
 && sudo rm -f /nix/var/nix/daemon-socket/socket
