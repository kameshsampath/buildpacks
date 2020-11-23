PACK_CMD?=pack

GIT_TAG := $(shell git tag --points-at HEAD)
VERSION_TAG := $(shell [ -z $(GIT_TAG) ] && echo 'tip' || echo $(GIT_TAG) )

BASE_REPO  := quay.io/kameshsampath/cnbs-base
BUILD_REPO := quay.io/kameshsampath/cnbs-build
RUN_REPO   := quay.io/kameshsampath/cnbs-run

JAVA_MAVEN_JVM_BUILDER_REPO := quay.io/kameshsampath/java-11-jvm-builder
JAVA_MAVEN_JVM_BUILDPACK_REPO := quay.io/kameshsampath/java-11-jvm-bp
QUARKUS_NATIVE_BUILDPACK_REPO := quay.io/kameshsampath/quarkus-native-bp

.PHONY:	stacks	buildpacks	builders

all:	stacks	buildpacks	builders

stacks:	
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/ubi8
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/ubi8-minimal
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/java-11
	./stacks/build-stack.sh -v $(VERSION_TAG) stacks/quarkus-native

buildpacks:	
	$(PACK_CMD) package-buildpack $(JAVA_MAVEN_JVM_BUILDPACK_REPO):$(VERSION_TAG) --config ./packages/java-11/package.toml
	$(PACK_CMD) package-buildpack $(QUARKUS_NATIVE_BUILDPACK_REPO):$(VERSION_TAG) --config ./packages/quarkus-native/package.toml

builders:	
	TMP_BLDRS=$(shell mktemp -d) && \
	sed "s/{{VERSION}}/$(VERSION_TAG)/g" ./builders/java-11/builder.toml > $$TMP_BLDRS/java-11.toml && \
	sed "s/{{VERSION}}/$(VERSION_TAG)/g" ./builders/quarkus-native/builder.toml > $$TMP_BLDRS/quarkus-native.toml && \
	$(PACK_CMD) create-builder $(JAVA_MAVEN_JVM_BUILDER_REPO):$(VERSION_TAG) --config $$TMP_BLDRS/java-11.toml && \
	$(PACK_CMD) create-builder $(QUARKUS_NATIVE_BUILDPACK_REPO):$(VERSION_TAG) --config $$TMP_BLDRS/quarkus-native.toml && \
	rm -fr $$TMP_BLDRS

publish:
	@echo "Publish the image to remote repository"

