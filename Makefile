CACHE := $(HOME)/.cache/toktok-stack

SBT_PROJECTS := $(dir $(wildcard */build.sbt))

CACHEDIRS := $(foreach i,$(SBT_PROJECTS),$i.idea $iproject/project $iproject/target $itarget)

help:
	@echo "make cache    # set up local cache directories for Java/Scala projects"

cache: $(foreach i,$(CACHEDIRS),$(CURDIR)/$i)

$(CURDIR)/%: $(CACHE)/%
	rm -rf $@
	ln -sf $< $@

.PRECIOUS: $(CACHE)/%
$(CACHE)/%:
	mkdir -p $@

haskell:
	stack build --extra-lib-dirs=$(PWD)/bazel-bin/c-toxcore/toxcore
