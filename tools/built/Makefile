VERSION = $(shell make -s -C ../.. version)

build: build-release build-debug build-asan build-msan build-tsan
push: push-release push-debug push-asan push-msan push-tsan

build-%: built/Dockerfile.%
	docker build -t toxchat/toktok-stack:$(VERSION)-$* -t toxchat/toktok-stack:latest-$* built -f $<

push-%: build-%
	docker push toxchat/toktok-stack:$(VERSION)-$*
	docker push toxchat/toktok-stack:latest-$*

clean-%:
	docker rmi toxchat/toktok-stack:$(VERSION)-$*
	docker rmi toxchat/toktok-stack:latest-$*
	-docker rm $(docker ps -a | grep -o '^[0-9a-f]...........')
	-docker rmi $$(docker images -f "dangling=true" -q)

built/Dockerfile.%: src/Dockerfile.% Makefile ../../Makefile
	mkdir -p $(@D)
	sed -e 's/$$VERSION/$(VERSION)/g' $< > $@
