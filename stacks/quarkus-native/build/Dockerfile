ARG version=tip
FROM quay.io/kameshsampath/cnbs-build:ubi8-${version}

ARG stack_id
ENV CNB_STACK_ID=${stack_id}
LABEL io.buildpacks.stack.id=${stack_id}

ENV HOME /projects
WORKDIR $HOME

USER root
RUN dnf module install -y maven:3.6 \
    && dnf install -y wget maven tar gzip gcc glibc-devel zlib-devel \
    && dnf update -y \
    && dnf clean all -y \
    && chown ${CNB_USER_ID}:${CNB_GROUP_ID} $HOME \
    && wget -q -O - "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.1.0/graalvm-ce-java11-linux-amd64-20.1.0.tar.gz" | \
        tar -xzf - -C /opt \
    && mv /opt/graalvm-ce-java11-20.1.0 /opt/graalvm \
    && /opt/graalvm/bin/gu --auto-yes install native-image

ENV JAVA_HOME /opt/graalvm
ENV GRAALVM_HOME /opt/graalvm
ENV PATH $GRAALVM_HOME/bin:$PATH

# Set user and group (as declared in base image)
USER ${CNB_USER_ID}:${CNB_GROUP_ID}
