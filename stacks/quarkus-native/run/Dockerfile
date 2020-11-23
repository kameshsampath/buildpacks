ARG version=tip
FROM quay.io/kameshsampath/cnbs-run:ubi8-minimal-${version}

ARG stack_id
ENV CNB_STACK_ID=${stack_id}
LABEL io.buildpacks.stack.id=${stack_id}

ENV HOME /projects
WORKDIR $HOME

USER root
RUN chown cnb:cnb $HOME
USER cnb

ENV PORT 8080
