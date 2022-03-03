DOCKER ?= podman

docker-build:
	$(DOCKER)  build -t ghcr.io/rtdev7690/acme-resolver:latest . && $(DOCKER) push ghcr.io/rtdev7690/acme-resolver:latest
