VERSION = $(shell make -s -C ../.. version)

build: build-fastbuild build-release build-debug
push: push-fastbuild push-release push-debug

built: build-fastbuild
	docker build -t toxchat/toktok-stack:$(VERSION).built .

build-%: %/Dockerfile
	docker build -t toxchat/toktok-stack:$(VERSION).$* $*

push-%: build-%
	docker push toxchat/toktok-stack:$(VERSION).$*

%/Dockerfile: src/Dockerfile.in Makefile
	sed -e 's/$$VERSION/$(VERSION)/g' $< > $@
