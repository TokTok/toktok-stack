c-msgpack_VERSION		:= master
c-protobuf_VERSION		:= v3.5.0

c-toxcore_CMAKE_FLAGS		:= -DDEBUG=ON -DTRACE=ON -DSTRICT_ABI=ON -DASAN=OFF -DBUILD_NTOX=ON -DWARNINGS=ON -DERROR_ON_WARNING=ON
c-msgpack_CMAKE_FLAGS		:= -DMSGPACK_ENABLE_CXX=OFF -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF

SUBMODULES := $(notdir $(shell git submodule foreach -q pwd))

CABAL_PKGS := $(foreach P,$(SUBMODULES),$(if $(wildcard $P/*.cabal),$P/,))

DESTDIR := $(CURDIR)/_install

STACK := stack --stack-yaml $(CURDIR)/stack.yaml

STACK_FLAGS +=					\
	--extra-include-dirs=$(DESTDIR)/include	\
	--extra-lib-dirs=$(DESTDIR)/lib		\
	--install-ghc				\
	--color=always				\
	--ghc-options "-Werror"

# Explicitly set to empty.
export CFLAGS		:= -O3 -pipe
export CPPFLAGS		:= -I$(DESTDIR)/include
export CXXFLAGS		:= -O3 -pipe
export LDFLAGS		:= -L$(DESTDIR)/lib

export PATH		:= $(DESTDIR)/bin:$(DESTDIR)/lib:$(PATH)
export LD_LIBRARY_PATH	:= $(DESTDIR)/lib
export PKG_CONFIG_PATH	:= $(DESTDIR)/lib/pkgconfig

checksums.txt: $(foreach P,$(SUBMODULES),$(DESTDIR)/.$P.stamp)
	shasum $(sort $(wildcard $(DESTDIR)/bin/* $(DESTDIR)/lib/*.dll $(DESTDIR)/lib/*.dylib $(DESTDIR)/lib/*.so)) > $@

%/_build: %/CMakeLists.txt
	cd $(@D) && cmake -B_build -H. -DCMAKE_INSTALL_PREFIX:PATH=$(DESTDIR) $($*_CMAKE_FLAGS)

%/cpp/_build: %/CMakeLists.txt
	cd $(@D) && cmake -B_build -H. -DCMAKE_INSTALL_PREFIX:PATH=$(DESTDIR) $($*_CMAKE_FLAGS)

%/_build: %/Makefile.am
	cd $(@D) && autoreconf -fi
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
$(DESTDIR)/.jvm-toxcore-api.stamp: $(DESTDIR)/.jvm-macros.stamp $(DESTDIR)/.jvm-sbt-plugins.stamp
$(DESTDIR)/.jvm-macros.stamp: $(DESTDIR)/.jvm-sbt-plugins.stamp
$(DESTDIR)/.jvm-%.stamp: jvm-%/build.sbt
	@ls -l $^ > /dev/null
	cd $(<D) && sbt "testOnly *Test" publishLocal updateReadmeDependencies
	#cd $(<D) && sbt publishLocal updateReadmeDependencies
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

$(DESTDIR)/.c-toxcore-hs.stamp: $(DESTDIR)/.cabal.stamp
	$(MAKE) -C c-toxcore-hs
	@touch $@

$(DESTDIR)/.website.stamp: $(foreach f,$(shell cd hs-toxcore && git ls-files),hs-toxcore/$f)
	@touch $@

$(DESTDIR)/.dockerfiles.stamp:
	$(MAKE) -C dockerfiles
	@touch $@

$(DESTDIR)/.cabal.stamp: $(DESTDIR)/.c-toxcore.stamp stack.yaml $(foreach P,$(CABAL_PKGS),$(foreach f,$(shell cd $P && git ls-files),$P$f))
	$(STACK) install $(STACK_FLAGS) hlint stylish-haskell
	$(STACK) build $(STACK_FLAGS) #--test
	@touch $@

$(DESTDIR)/.apidsl.stamp: apidsl/.git
	opam install -y ocamlfind ppx_deriving menhir
	cd $(<D) && $(MAKE)
	@mkdir -p $(@D)
	@touch $@

$(DESTDIR)/.c-protobuf.stamp: c-protobuf/_build
	cd $< && ../configure --prefix=$(DESTDIR) --disable-shared CXXFLAGS="-fPIC"
	$(MAKE) -C $< install V=0
	@touch $@

c-toxcore/_build: $(DESTDIR)/.apidsl.stamp
c-toxcore/_build: $(DESTDIR)/.c-msgpack.stamp
$(DESTDIR)/.c-toxcore.stamp: c-toxcore/_build
	$(MAKE) -C $< install
	@touch $@

$(DESTDIR)/.c-msgpack.stamp: c-msgpack/_build
	$(MAKE) -C $< install
	@touch $@

qtox/_build: $(DESTDIR)/.c-toxcore.stamp
$(DESTDIR)/.qtox.stamp: qtox/_build
	$(MAKE) -C $< install
	@touch $@

jvm-toxcore-c-jni/cpp/_build: $(DESTDIR)/.c-toxcore.stamp
$(DESTDIR)/.jvm-toxcore-c.stamp: $(DESTDIR)/.jvm-toxcore-c-jni.stamp
$(DESTDIR)/.jvm-toxcore-c-jni.stamp: jvm-toxcore-c/cpp/_build
	$(MAKE) -C $< install
	@touch $@

clean:
	$(MAKE) -C apidsl clean
	for P in $(CABAL_PKGS); do		\
		(cd $$P && cabal clean);	\
	done
	rm -rf c-protobuf/_build c-protobuf/config.h.in~
	rm -rf c-msgpack/_build
	rm -rf c-toxcore/_build
	rm -rf jvm-toxcore-c/cpp/_build
	rm -rf qtox/_build
	rm -rf $(DESTDIR)

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

foo:
	cd jvm-toxcore-c && ./build-x86_64-linux
