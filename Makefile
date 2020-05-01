IMAGE		= toxchat/toktok-stack:0.0.9
DOWNLOADS	= toxchat/toktok-stack:downloads

CACHE		= /tmp/build_cache
OUTPUT		= /dev/shm/build_output

# You can override with e.g. "make run ACTION=test".
ACTION		= build

#######################################
# The main build targets

# Build the Docker image.
build: build-workspace

# Run the Bazel build in the built image without persisting any state.
run:
	docker run --rm -it $(IMAGE) bazel $(ACTION) //...

run-local: $(CACHE) $(OUTPUT)
	docker run -v $(CURDIR):/src/workspace $(DOCKERFLAGS)

run-persistent: $(CACHE) $(OUTPUT)
	docker run $(DOCKERFLAGS)

# Common flags for the rules above.
DOCKERFLAGS := --rm -it					\
	-v $(CACHE):/tmp/build_cache			\
	-v $(OUTPUT):/tmp/build_output			\
	$(IMAGE) bazel					\
	--output_user_root=/tmp/build_cache		\
	--output_base=/tmp/build_output			\
	$(ACTION) //...

#######################################
# Implementation details follow

# Filter out all submodule names, because otherwise we tar up entire
# directories, not just the files. git ls-files lists submodules as "files".
FILTER := "^($(shell echo $(shell git submodule --quiet foreach --recursive pwd | sed -e "s@^$(CURDIR)/@@") | sed -e 's/ /|/g'))$$"

# git ls-files --recurse-submodules doesn't quite work. For some reason it
# completely ignores ci-tools. This may have been because the git repo is
# somehow broken, but this method is more robust.
LS_FILES := git ls-files | sed -e "s@^@$$(pwd)/@"
LS_FILES_RECURSIVE :=						\
	$(LS_FILES);						\
	git submodule --quiet foreach --recursive '$(LS_FILES)'	\

# Filter out Makefile (because we're ofter changing it when developing the
# Docker image) and sbt project directories, because we've got some hacks in
# there using symlinks and we don't need them for Bazel builds.
FILES :=					\
	($(LS_FILES_RECURSIVE))			\
	| sed -e 's@^$(CURDIR)/@@'		\
	| egrep -v '^jvm-[^/]*/project'		\
	| egrep -v '^Makefile'			\
	| egrep -v '.gitignore'			\
	| egrep -v $(FILTER)			\
	| sort -u

# https://github.com/golang/go/issues/37436
DOCKER_BUILD = docker build --ulimit memlock=67108864

# We use an intermediate target here so "make" does the cleanup of workspace.tar
# for us. It has to be 2 levels deep, otherwise it's considered "precious".
build-%: %.tar downloads-%
	$(DOCKER_BUILD) -t $(IMAGE) - < $<

build-kythe: kythe.tar tools/kythe/Dockerfile
	$(DOCKER_BUILD) -t toxchat/kythe-tables -f kythe/tools/kythe/Dockerfile - < $<
	$(DOCKER_BUILD) -t toxchat/kythe-serving dockerfiles/kythe/serving

TAR = tar --mode=ugo+rx --transform 's,^,$*/,;s,^$*/Dockerfile,Dockerfile,'

# This is the intermediate image, which is huge and doesn't try to be efficient.
# We copy the populated third_party directory from it into the final image.
downloads-%: Dockerfile tools/prepare_third_party.sh
	$(TAR) -c Dockerfile tools/prepare_third_party.sh \
		| docker build --target downloads -t $(DOWNLOADS) -

# Build a .tar with the workspace in it. This will be unpacked in the
# Dockerfile. We use $(...) in bash instead of $(shell) in make because
# otherwise the command line will be too large. We use --mode to give read
# permissions to everyone. We make everything executable, because some things
# need to be, and we have no easy way to be selective.
%.tar: Makefile
	$(TAR) -hcf $@ $$($(FILES))

# Bazel build products will end up here.
$(CACHE):  ; mkdir $@
$(OUTPUT): ; mkdir $@

# We need this for $(...) to work.
SHELL = bash
