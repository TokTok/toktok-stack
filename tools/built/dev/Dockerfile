# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Copy the local workspace changes.
COPY --chown=builder:users workspace /src/workspace/
# Add builder's editor configs and other dotfiles.
COPY --chown=builder:users home /home/builder/
# Generate compilation database for the first time.
RUN ["tools/built/dev/setup.sh"]

# Set this to your GitHub username so the git remotes are set up correctly.
ENV GITHUB_USER=iphydf

ENTRYPOINT ["/src/workspace/tools/built/dev/init.sh"]
