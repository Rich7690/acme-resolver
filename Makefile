DOCKER ?= podman

docker-build:
	$(DOCKER)  build -t ghcr.io/rich7690/acme-resolver:latest . && $(DOCKER) push ghcr.io/rich7690/acme-resolver:latest
