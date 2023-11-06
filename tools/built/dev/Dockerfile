# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Add user config overrides and keys.
COPY --chown=builder:users home /home/builder/

# Also for local development: add this file again, so local changes are
# reflected.
COPY --chown=builder:users workspace/tools/built/dev/setup-local.sh /src/workspace/tools/built/dev/
# Set up Vundle and any plugins the user may want.
RUN ["/src/workspace/tools/built/dev/setup-local.sh"]

# Return to root, so that "docker run" can run /usr/sbin/init.
# hadolint ignore=DL3002
USER root
