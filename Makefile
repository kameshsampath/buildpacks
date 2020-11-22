PACK_CMD?=pack

GIT_TAG := $(shell git tag --points-at HEAD)
VERSION_TAG := $(shell [ -z $(GIT_TAG) ] && echo 'tip' || echo $(GIT_TAG) )

BASE_REPO  := quay.io/kameshsampath/cnbs-base
BUILD_REPO := quay.io/kameshsampath/cnbs-build
RUN_REPO   := quay.io/kameshsampath/cnbs-run

.PHONY:	stacks	buildpacks	builders

all:	stacks	buildpacks	builders

stacks:	
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/ubi8
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/ubi8-minimal
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/java-11

buildpacks:	
	@echo "Building buildpacks"

builders:	
	@echo "Building buildpack builders"

