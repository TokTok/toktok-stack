# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Copy the local workspace changes and build and test again.
COPY --chown=builder:users workspace /src/workspace/
RUN ["bazel", "build", "--show_timestamps", "//..."]

# Add builder's editor configs and other dotfiles.
COPY --chown=builder:users home /home/builder/
RUN git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim \
 && vi --not-a-term +PluginInstall +qall

# Set this to your GitHub username so the git remotes are set up correctly.
ENV GITHUB_USER=iphydf

USER root
ENTRYPOINT ["/src/workspace/tools/built/init.sh"]
