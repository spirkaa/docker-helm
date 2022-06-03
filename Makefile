.POSIX:

export DOCKER_BUILDKIT=1

IMAGE_FULLNAME=git.devmem.ru/projects/helm
IMAGE_TAG=latest
IMAGE=${IMAGE_FULLNAME}:${IMAGE_TAG}

default: build

build:
	@docker build \
		--cache-from ${IMAGE} \
		--tag ${IMAGE} \
		-f .docker/Dockerfile .

build-nocache:
	@docker build \
		--pull --no-cache \
		--tag ${IMAGE} \
		-f .docker/Dockerfile .

rmi:
	@docker rmi ${IMAGE}

run:
	@docker run \
		--rm \
		--interactive \
		--tty \
		${IMAGE}
