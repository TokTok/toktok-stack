VERSION = $(shell make -s -C ../.. version)

build: build-release
push: push-release

build: build-debug
push: push-debug

build-%: built/Dockerfile.%
	docker build -t toxchat/toktok-stack:$(VERSION)-$* built -f $<
	docker build -t toxchat/toktok-stack:latest-$* built -f $<

push-%: build-%
	docker push toxchat/toktok-stack:$(VERSION)-$*
	docker push toxchat/toktok-stack:latest-$*

built/Dockerfile.%: src/Dockerfile.% Makefile ../../Makefile
	mkdir -p $(@D)
	sed -e 's/$$VERSION/$(VERSION)/g' $< > $@
