ARG version=tip
FROM quay.io/kameshsampath/cnbs-build:ubi8-${version}

ARG stack_id
ENV CNB_STACK_ID=${stack_id}
LABEL io.buildpacks.stack.id=${stack_id}

ENV HOME /projects
ENV MAVEN_HOME=/usr/share/maven
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

WORKDIR $HOME

USER root

RUN dnf module install -y maven:3.6 \
    && dnf install -y wget maven tar gzip java-11-openjdk-headless \
    && dnf update -y \
    && dnf clean all -y \
    && chown ${CNB_USER_ID}:${CNB_GROUP_ID} $HOME

COPY extras/settings.xml $MAVEN_HOME/conf/settings.xml

RUN chgrp -R ${CNB_GROUP_ID} /usr/share/maven/conf \
    && chmod -R g=u /usr/share/maven/conf \
    && chmod -R g+=rwx  /usr/share/maven/conf

# Set user and group (as declared in base image)
USER ${CNB_USER_ID}:${CNB_GROUP_ID}
