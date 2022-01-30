# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Copy the local workspace changes and build again.
COPY --chown=builder:users workspace /src/workspace/
RUN ["bazel", "build", "--show_timestamps", "--config=remote", "//..."]

ENV BAZEL_COMPDB_BAZEL_PATH=bazel-nomodules

# Add builder's editor configs and other dotfiles.
# Generate compilation database for the first time.
COPY --chown=builder:users home /home/builder/
RUN git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim \
 && vi --not-a-term +PluginInstall +qall \
 && cat ~/.vim/settings.vim >> ~/.vimrc \
 && sudo install -o root -g root -m 755 /src/workspace/tools/built/dev/bazel-nomodules /usr/local/bin/bazel-nomodules \
 && ~/.vim/bundle/bazel-compilation-database/generate.py

# Set this to your GitHub username so the git remotes are set up correctly.
ENV GITHUB_USER=iphydf

# hadolint ignore=DL3002
USER root
ENTRYPOINT ["/src/workspace/tools/built/dev/init.sh"]
