VERSION = $(shell make -s -C ../.. version)

build: build-third_party
push: push-third_party

build-%: built/Dockerfile.%
	docker build -t toxchat/toktok-stack:$(VERSION)-$* built -f $<

push-%: build-%
	docker push toxchat/toktok-stack:$(VERSION)-$*

built/Dockerfile.%: src/Dockerfile.in Makefile
	mkdir -p $(@D)
	sed -e 's/$$VERSION/$(VERSION)/g;s/$$TARGET/$*/g' $< > $@
