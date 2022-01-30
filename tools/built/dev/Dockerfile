# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Set this to your GitHub username so the git remotes are set up correctly.
ENV GITHUB_USER=iphydf

# Add builder's editor configs and other dotfiles.
COPY --chown=builder:users . /home/builder/
# Set up Vundle and any plugins the user may want.
RUN git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim \
 && vi --not-a-term +PluginInstall +qall \
 && cat ~/.vim/settings.vim >>~/.vimrc
