c-msgpack_VERSION		:= master
c-opus_VERSION			:= v1.1.3
c-protobuf_VERSION		:= v3.1.0
c-sodium_VERSION		:= 1.0.11
c-vpx_VERSION			:= v1.6.0

c-toxcore_CMAKE_FLAGS		:= -DDEBUG=ON -DSTRICT_ABI=ON -DASAN=OFF
c-msgpack_CMAKE_FLAGS		:= -DMSGPACK_ENABLE_CXX=OFF -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF

SUBMODULES := $(notdir $(shell git submodule foreach -q pwd))

CABAL_PKGS := $(foreach P,$(SUBMODULES),$(if $(wildcard $P/*.cabal),$P/,))

DESTDIR := $(CURDIR)/_install

STACK := stack --stack-yaml $(CURDIR)/stack.yaml

STACK_FLAGS :=						\
	--extra-include-dirs=$(CURDIR)/_install/include	\
	--extra-lib-dirs=$(CURDIR)/_install/lib		\
	--ghc-options "-Werror"

# Explicitly set to empty.
export CFLAGS		:=
export CPPFLAGS		:= -I$(DESTDIR)/include
export CXXFLAGS		:=
export LDFLAGS		:= -L$(DESTDIR)/lib

export PATH		:= $(DESTDIR)/bin:$(PATH)
export LD_LIBRARY_PATH	:= $(DESTDIR)/lib
export PKG_CONFIG_PATH	:= $(DESTDIR)/lib/pkgconfig

checksums.txt: $(foreach P,$(SUBMODULES),$(DESTDIR)/.$P.stamp)
	shasum $(sort $(wildcard _install/bin/* _install/lib/*.dll _install/lib/*.dylib _install/lib/*.so)) > $@

%/_build: %/CMakeLists.txt
	cd $* && cmake -B_build -H. -DCMAKE_INSTALL_PREFIX:PATH=$(CURDIR)/_install $($*_CMAKE_FLAGS)

%/_build: %/Makefile.am
	cd $(<D) && autoreconf -fi
	mkdir -p $(<D)/_build

# Add dependencies for each .stamp file on the sources according to git ls-files.
define stamp-dependencies
$(DESTDIR)/.$1.stamp: $$(foreach f,$$(shell cd $1 && git ls-files),$1/$$f)
endef

$(foreach M,$(SUBMODULES),$(eval $(call stamp-dependencies,$M)))

# All *-toxcore-c bindings depend on c-toxcore.
$(DESTDIR)/.hs-toxcore-c.stamp: $(DESTDIR)/.c-toxcore.stamp
$(DESTDIR)/.js-toxcore-c.stamp: $(DESTDIR)/.c-toxcore.stamp
$(DESTDIR)/.jvm-toxcore-c.stamp: $(DESTDIR)/.c-toxcore.stamp
$(DESTDIR)/.py-toxcore-c.stamp: $(DESTDIR)/.c-toxcore.stamp

$(DESTDIR)/.jvm-toxcore-c.stamp: $(DESTDIR)/.jvm-toxcore-api.stamp $(DESTDIR)/.c-protobuf.stamp
$(DESTDIR)/.jvm-toxcore-api.stamp: $(DESTDIR)/.jvm-macros.stamp $(DESTDIR)/.jvm-sbt-plugins.stamp $(DESTDIR)/.jvm-linters.stamp
$(DESTDIR)/.jvm-macros.stamp: $(DESTDIR)/.jvm-sbt-plugins.stamp
$(DESTDIR)/.jvm-linters.stamp: $(DESTDIR)/.jvm-sbt-plugins.stamp
$(DESTDIR)/.jvm-%.stamp: jvm-%/build.sbt
	cd $(<D) && sbt test:compile publishLocal updateReadmeDependencies
	@touch $@

$(DESTDIR)/.toktok.stamp: toktok/build.sbt
	if which android; then cd $(<D) && sbt android:package; fi
	@touch $@

$(DESTDIR)/.py-%.stamp: py-%/setup.py
	cd $(<D) && python setup.py install		\
		--record $(DESTDIR)/.py-$*-files.txt	\
		--prefix=$(DESTDIR)
	@touch $@

$(DESTDIR)/.%.stamp: %/Setup.lhs $(DESTDIR)/.cabal.stamp
	@touch $@

$(DESTDIR)/.js-%.stamp: js-%/Gruntfile.js
	@touch $@

$(DESTDIR)/.c-toxcore-hs.stamp:
#	$(MAKE) -C c-toxcore-hs
	@touch $@

$(DESTDIR)/.website.stamp: $(DESTDIR)/.cabal.stamp $(foreach f,$(shell cd hs-toxcore && git ls-files),hs-toxcore/$f)
	cd hs-toxcore && $(STACK) exec -- semdoc src/tox/Network/Tox.lhs $(CURDIR)/website/toktok/src/content/spec.md
#	$(STACK) exec -- hub-changelog TokTok c-toxcore > $(CURDIR)/website/toktok/src/content/changelog/c-toxcore.md
	cd website/toktok && $(STACK) exec -- yst
	rm -rf $(DESTDIR)/site
	mv website/toktok/site $(DESTDIR)/
	! which linkchecker || linkchecker --ignore-url "https://travis-ci.org.*" --ignore-url "irc://.*" $(DESTDIR)/site/
	@touch $@

$(DESTDIR)/.dockerfiles.stamp:
	$(MAKE) -C dockerfiles
	@touch $@

$(DESTDIR)/.cabal.stamp: $(DESTDIR)/.c-toxcore.stamp $(foreach P,$(CABAL_PKGS),$(foreach f,$(shell cd $P && git ls-files),$P$f))
	$(STACK) install $(STACK_FLAGS) hlint stylish-haskell
	$(STACK) build $(STACK_FLAGS) --test
	@touch $@

$(DESTDIR)/.apidsl.stamp: apidsl/.git
	opam install -y ocamlfind ppx_deriving menhir
	cd $(<D) && $(MAKE)
	@mkdir -p $(@D)
	@touch $@

$(DESTDIR)/.c-protobuf.stamp: c-protobuf/_build
	cd $< && ../configure --prefix=$(DESTDIR) --disable-shared CXXFLAGS="-fPIC"
	$(MAKE) -C $< install
	@touch $@

$(DESTDIR)/.c-sodium.stamp: c-sodium/_build
	cd $< && ../configure --prefix=$(DESTDIR) --disable-shared --disable-pie CFLAGS="-fPIC"
	$(MAKE) -C $< install
	@touch $@

$(DESTDIR)/.c-vpx.stamp: c-vpx/.git
	mkdir -p $(<D)/_build
	cd $(<D)/_build && ../configure --prefix=$(CURDIR)/_install --disable-examples --disable-docs --disable-unit-tests --disable-install-bins --enable-pic --disable-shared
	$(MAKE) -C $(<D)/_build install
	@touch $@

$(DESTDIR)/.c-msgpack.stamp: c-msgpack/_build
	$(MAKE) -C $< install
	@touch $@

$(DESTDIR)/.c-opus.stamp: c-opus/_build
	cd $< && ../configure --prefix=$(DESTDIR) --disable-shared CFLAGS="-fPIC"
	$(MAKE) -C $< install
	@touch $@

c-toxcore/_build: $(DESTDIR)/.c-vpx.stamp $(DESTDIR)/.c-sodium.stamp $(DESTDIR)/.c-opus.stamp $(DESTDIR)/.apidsl.stamp
$(DESTDIR)/.c-toxcore.stamp: c-toxcore/_build
	$(MAKE) -C $< install
	@touch $@

qtox/_build: $(DESTDIR)/.c-toxcore.stamp
$(DESTDIR)/.qtox.stamp: qtox/_build
	$(MAKE) -C $< install
	@touch $@

clean:
	$(MAKE) -C apidsl clean
	for P in $(CABAL_PKGS); do		\
		(cd $$P && cabal clean);	\
	done
	-$(MAKE) -C c-vpx/_build distclean
	rm -rf c-protobuf/_build
	rm -rf c-msgpack/_build
	rm -rf c-opus/_build
	rm -rf c-sodium/_build
	rm -rf c-toxcore/_build
	rm -rf c-vpx/_build
	rm -rf qtox/_build

git-clean:
	git submodule foreach -q --recursive git clean -fdx
	git submodule foreach -q --recursive git checkout .
	git clean -fdx

checkout: $(SUBMODULES:=.checkout)
%.checkout:
	cd $* && git checkout $(if $($(*F)_VERSION),$($(*F)_VERSION),master)

fetch: $(SUBMODULES:=.fetch)
%.fetch:
	cd $* && git fetch --all

pull: $(SUBMODULES:=.pull)
%.pull:
	cd $* && git checkout master && git pull

merge-master: $(SUBMODULES:=.merge-master)
%.merge-master:
	if [ -z "$($(*F)_VERSION)" ]; then cd $* && git checkout master && git merge upstream/master; fi

show-branches: $(SUBMODULES:=.show-branches)
%.show-branches:
	cd $* && git branch

status: $(SUBMODULES:=.status)
%.status:
	cd $* && git status

%/.travis.yml: %/.leaf.yml github-tools/tools/expand-yaml $(wildcard github-tools/templates/*.yml)
	github-tools/tools/expand-yaml $< $@
