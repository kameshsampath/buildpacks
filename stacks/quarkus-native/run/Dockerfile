ARG version=tip
FROM quay.io/kameshsampath/cnbs-run:ubi8-minimal-${version}

ARG stack_id
ENV CNB_STACK_ID=${stack_id}
LABEL io.buildpacks.stack.id=${stack_id}

ENV HOME /projects
WORKDIR $HOME

USER root
RUN chown ${CNB_USER_ID}:${CNB_GROUP_ID} $HOME

ENV PORT 8080

# Set user and group (as declared in base image)
USER ${CNB_USER_ID}:${CNB_GROUP_ID}
