# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Copy the local workspace changes and build again.
COPY --chown=builder:users workspace /src/workspace/
RUN ["bazel", "build", "--show_timestamps", "--config=remote", "//..."]

# Add builder's editor configs and other dotfiles.
# Generate compilation database for the first time.
COPY --chown=builder:users home /home/builder/
RUN ["tools/built/dev/setup.sh"]

# Set this to your GitHub username so the git remotes are set up correctly.
ENV GITHUB_USER=iphydf

# hadolint ignore=DL3002
USER root
ENTRYPOINT ["/src/workspace/tools/built/dev/init.sh"]
