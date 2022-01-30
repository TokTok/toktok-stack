IMAGE		= toxchat/toktok-stack:latest

CACHE		= /tmp/build_cache
OUTPUT		= /dev/shm/build_output

# You can override with e.g. "make run ACTION=test TARGET=//c-toxcore/...".
ACTION		= build
TARGET		= //...

#######################################
# The main build targets

# Build the Docker image.
build: build-workspace
	$(MAKE) -C tools/built

push: push-workspace
	$(MAKE) -C tools/built push

version:
	@echo $(IMAGE_VERSION)

# Run the Bazel build in the built image without persisting any state.
run:
	docker run --rm -it $(IMAGE) bazel $(ACTION) $(TARGET)

run-local: $(CACHE) $(OUTPUT)
	docker run -v $(CURDIR):/src/workspace $(DOCKERFLAGS)

run-persistent: $(CACHE) $(OUTPUT)
	docker run $(DOCKERFLAGS)

# Common flags for the local and persistent rules above.
DOCKERFLAGS := --rm -it					\
	-v $(CACHE):/tmp/build_cache			\
	-v $(OUTPUT):/tmp/build_output			\
	$(IMAGE) bazel					\
	--output_user_root=/tmp/build_cache		\
	--output_base=/tmp/build_output			\
	$(ACTION) $(TARGET)

#######################################
# Implementation details follow

# Filter out all submodule names, because otherwise we tar up entire
# directories, not just the files. git ls-files lists submodules as "files".
LS_SUBMODULES := if [ -f .gitmodules ]; then grep "path = " .gitmodules | sed -e "s|	path = |$$(pwd)/|"; fi
SUBMODULES := $(patsubst $(CURDIR)/%,%,$(shell $(LS_SUBMODULES) && git submodule --quiet foreach --recursive '$(LS_SUBMODULES)'))
FILTER := "^($(shell echo $(SUBMODULES) | sed -e 's/ /|/g'))$$"

# git ls-files --recurse-submodules doesn't quite work. For some reason it
# completely ignores ci-tools. This may have been because the git repo is
# somehow broken, but this method is more robust.
LS_FILES := git ls-files | sed -e "s@^@$$(pwd)/@"
LS_FILES_RECURSIVE :=						\
	$(LS_FILES);						\
	git submodule --quiet foreach --recursive '$(LS_FILES)'	\

# Filter out Makefile (because we're ofter changing it when developing the
# Docker image) and sbt project directories, because we've got some hacks in
# there using symlinks and we don't need them for Bazel builds. Also filter out
# some other files not needed for Bazel builds.
FILES :=						\
	($(LS_FILES_RECURSIVE))				\
	| sed -e 's@^$(CURDIR)/@@'			\
	| grep -E -v $(FILTER)				\
	| grep -E -v '^\.github'			\
	| grep -E -v '^c-toxcore/\.github/scripts'	\
	| grep -E -v '^c-toxcore/\.github/workflows'	\
	| grep -E -v '^c-toxcore/other/analysis'	\
	| grep -E -v '^c-toxcore/other/astyle'		\
	| grep -E -v '^c-toxcore/other/docker'		\
	| grep -E -v '^jvm-[^/]*/project'		\
	| grep -E -v '^tools/debug'			\
	| grep -E -v '^Makefile'			\
	| grep -E -v '^README.md'			\
	| grep -E -v '^\.bazelrc.local.example'		\
	| grep -E -v '/\.circleci'			\
	| grep -E -v '/\.clang-format'			\
	| grep -E -v '/\.editorconfig'			\
	| grep -E -v '/\.eslintrc\.json'		\
	| grep -E -v '/\.github/dependabot\.yml'	\
	| grep -E -v '/\.github/release-drafter\.yml'	\
	| grep -E -v '/\.hadolint\.yaml'		\
	| grep -E -v '/\.hlint\.yaml'			\
	| grep -E -v '/\.md-style\.rb'			\
	| grep -E -v '/\.prettier'			\
	| grep -E -v '/\.restyled.yaml'			\
	| grep -E -v '/\.travis'			\
	| grep -E -v '/Gruntfile\.js'			\
	| grep -E -v '/Procfile'			\
	| grep -E -v '/Makefile'			\
	| grep -E -v '/appveyor\.yml'			\
	| grep -E -v '/checkstyle-config\.xml'		\
	| grep -E -v '/configure'			\
	| grep -E -v '/netlify.toml'			\
	| grep -E -v '/package-lock\.json'		\
	| grep -E -v '/stack\.yaml'			\
	| grep -E -v 'CMake'				\
	| grep -E -v '\.cmake$$'			\
	| grep -E -v '\.gitattributes$$'		\
	| grep -E -v '\.gitignore$$'			\
	| grep -E -v '\.gitmodules$$'			\
	| grep -E -v '\.m4$$'				\
	| grep -E -v '\.sbt$$'				\
	| sort -u

# https://github.com/golang/go/issues/37436
DOCKER_BUILD = docker build --ulimit memlock=67108864

.INTERMEDIATE: workspace.tar
build-workspace: workspace.tar
	$(DOCKER_BUILD) --cache-from "$(IMAGE)-third_party" -t "$(IMAGE)-third_party" -f workspace/tools/built/src/Dockerfile.third_party - < $<
	$(DOCKER_BUILD) --cache-from "$(IMAGE)" -t $(IMAGE) -f workspace/tools/built/src/Dockerfile - < $<
	#$(DOCKER_BUILD) -t $(IMAGE) - < $<
	-docker rm $(docker ps -a | grep -o '^[0-9a-f]...........')
	-docker rmi $(docker images -f "dangling=true" -q)

push-workspace:
	docker push $(IMAGE)-third_party
	docker push $(IMAGE)

.INTERMEDIATE: kythe.tar
build-kythe: kythe.tar tools/kythe/Dockerfile
	$(DOCKER_BUILD) -t toxchat/kythe-tables -f kythe/tools/kythe/Dockerfile - < $<
	$(DOCKER_BUILD) -t toxchat/kythe-serving dockerfiles/kythe/serving

push-kythe:
	docker push toxchat/kythe-serving:latest

TAR = tar --mode=ugo+rx --transform 's,^,$*/,;s,$*/toolchain,toolchain,'

# Build a .tar with the workspace in it. This will be unpacked in the
# Dockerfile. We use $(...) in bash instead of $(shell) in make because
# otherwise the command line will be too large. We use --mode to give read
# permissions to everyone. We make everything executable, because some things
# need to be, and we have no easy way to be selective.
%.tar: Makefile toolchain/LICENSE
	tools/project/update_versions.sh
	$(TAR) -hcf $@ $$($(FILES)) $$(find toolchain -type f)

toolchain/LICENSE: tools/prepare_toolchain.sh
	$<

# Bazel build products will end up here.
$(CACHE):  ; mkdir $@
$(OUTPUT): ; mkdir $@

# We need this for $(...) to work.
SHELL = bash

#######################################
# MyPy type checking

THIS_REPO_FILES := $(shell $(LS_FILES) | sed -e 's@^$(CURDIR)/@@' | grep -E -v $(FILTER))
PYTHON_LIB_FILES := $(filter-out .%,$(sort $(shell ls $(filter %.py,$(THIS_REPO_FILES)))))
PYTHON_BIN_FILES := $(shell ls $(THIS_REPO_FILES) | xargs grep -l '^\#!/usr/bin/.*python3')

MYPY_FLAGS :=				\
	--disallow-any-explicit		\
	--disallow-redefinition		\
	--color-output			\
	--strict

mypy: $(PYTHON_BIN_FILES:=.mypy)

%.mypy: % $(PYTHON_LIB_FILES)
	@echo "  MYPY  $<"
	@mypy $(MYPY_FLAGS) $+
