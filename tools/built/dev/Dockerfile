# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Add default configs and dotfiles.
COPY --chown=builder:users workspace/tools/built/dev/home /home/builder/
# Add user config overrides and keys.
COPY --chown=builder:users home /home/builder/
# Set up Vundle and any plugins the user may want.
RUN ["/src/workspace/tools/built/src/setup-local.sh"]
