# Example dev container Dockerfile.
#
# See run_dev_container.sh for an example usage.
FROM toxchat/toktok-stack:latest-dev

# Add default configs and dotfiles.
COPY --chown=builder:users workspace/tools/built/dev/home /home/builder/
# Add user config overrides and keys.
COPY --chown=builder:users home /home/builder/
# Set up Vundle and any plugins the user may want.
RUN git clone --depth=1 https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim \
 && vi --not-a-term +PluginInstall +qall \
 && cat ~/.vim/settings.vim >>~/.vimrc
